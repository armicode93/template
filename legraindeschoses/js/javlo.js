// javlo.js v2.1.4

var ajaxNavDone = false;

document.addEventListener("DOMContentLoaded", function (event) {
	if ($(".chosen-select").length > 0) {
		$(".chosen-select").chosen();
	}
	$(document).click(function (e) {
		var cardWrapped = false;
		var parent = e.target;
		while (parent != null) {
			if ($(parent).is('.card')) {
				cardWrapped = true;
			}
			parent = parent.parentElement;
		}
		if (!cardWrapped) {
			$('#main-nav .collapse').collapse('hide');
		}
	});
	copyTitle();
	updateAjaxLinks();
	updateAjaxForms();
	staticSearch();
	ajaxNav();
	popup();
	sessionStoreItem();
	confirmAction();
	var sessionStoreThread = setInterval(sessionStoreItem, 2000);
	var basicScroll = parseInt(jQuery('body').css('padding-top')) + parseInt(jQuery('body').css('margin-top'));
	if (jQuery(".navbar.fixed-top").length > 0) {
		jQuery("body").addClass("scrolled");
		var basicScroll = jQuery(".navbar.fixed-top").outerHeight();
		jQuery("body").removeClass("scrolled");
	}
	basicScroll--;
	jQuery('.js-scroll-trigger[href*="#"]:not([href="#"]), .page-reference a[href*="#"]:not([href="#"])').click(function () {
		if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
			var target = jQuery(this.hash);
			target = target.length ? target : jQuery('[name=' + this.hash.slice(1) + ']');
			if (target.length) {
				var scrollTarget = (target.offset().top - basicScroll);
				if (scrollTarget < 100) {
					scrollTarget = 0;
				}
				jQuery('html, body').animate({
					scrollTop: scrollTarget
				}, {
						duration: 1000,
						specialEasing: {
							scrollTop: "swing"
						}
					});
				return false;
			}
		}
	});

	jQuery(".carousel").each(function () {
		this.addEventListener('touchstart', handleTouchStart, false);
		this.addEventListener('touchmove', handleTouchMove, false);
	});

	jQuery('.js-scroll-trigger').click(function () {
		jQuery('.navbar-collapse').collapse('hide');
	});

	displayIfTrue();
	initParallax();

	initCollapseBootstrap(".collapse-title");
	initCollapseLinkBootstrap(".collapse-link", false);
});

function confirmAction() {
	var items = document.querySelectorAll("[data-confirmAction]");
	for (var i = 0; i < items.length; i++) {
		items[i].addEventListener("click", function (e) {
			if (!confirm(this.getAttribute('data-confirmAction'))) {
				e.preventDefault();
				return false;
			}
		});
	}
}

function sessionStoreItem() {
	var items = document.querySelectorAll(".session-store");
	for (var i = 0; i < items.length; i++) {
		var id = items[i].getAttribute("id");
		if (id != null) {
			var value = sessionStorage.getItem(id);
			if (value != null && items[i].value.length == 0 && !items[i].sessionLoaded) {
				items[i].value = value;;
				items[i].sessionLoaded = true;
				var form = $(items[i]).closest("form");
				if (form != null) {
					form.on("submit", function () {
						$(this).find(".session-store").each(function () {
							if ($(this).attr("id") != null) {
								sessionStorage.removeItem($(this).attr("id"));
							}
						});
					});
				}
			}
			if (items[i].value.length > 0) {
				sessionStorage.setItem(id, items[i].value);
			} else {
				sessionStorage.removeItem(id);
			}
		};
	}
}

var POPUPURLNAME = "_popupurl";
function popup() {
	console.log("new popup");
	var popupParaUrl = findGetParameter(POPUPURLNAME);
	if (popupParaUrl != null) {
		openPopup(popupParaUrl, popupParaUrl);
	}
	$('a.popup').click(function () {
		var url = $(this).attr("href");
		url = addParam(window.location.href, POPUPURLNAME + '=' + url);
		window.history.pushState("popup", $(this).attr("title"), url);
		openPopup($(this).attr("title"), $(this).attr("href"));
		return false;
	});
}

document.onkeydown = function (e) {
	if (e.key == "Escape") {
		return closePopup();
	}
};

window.addEventListener('popstate', function (event) {
	if (ajaxNavDone) {
		updateAreas(window.location.href);
	}
	return closePopup();
});

function openPopup(title, url) {
	$("body").append('<div class="main-popup loader"><div class="wrapper">...</div></div>');
	$('.main-popup').click(function () {
		$(this).remove();
	});
	$.ajax({
		type: 'GET',
		url: url,
		data: { 'only-area': 'content', 'only-area-wrapper': 'true' }
	}).done(function (html) {
		$(".main-popup.loader").remove();
		$("body").append('<div class="main-popup"><div class="wrapper">' + html + '</div><div class="close-popup">x</div></div>');
		$('.main-popup .close-popup').click(function () {
			return closePopup();
		});
		/*$('.main-popup').click(function () {
			return closePopup();
		});*/
		$('.carousel').carousel();
	});
}

function closePopup() {
	if ($('.main-popup').length == 0) {
		return true;
	} else {
		$('.main-popup').remove();
		var newUrl = removeParam(window.location.href, POPUPURLNAME);
		if (newUrl != window.location.href) {
			window.history.pushState(null, null, newUrl);
		}
		return false;
	}
}

function addParam(url, params) {
	var isQuestionMarkPresent = url && url.indexOf('?') !== -1,
		separator = '';
	if (params) {
		separator = isQuestionMarkPresent ? '&' : '?';
		url += separator + params;
	}
	return url;
}

function findGetParameter(parameterName, defaultValue) {
	var result = null,
		tmp = [];
	location.search
		.substr(1)
		.split("&")
		.forEach(function (item) {
			tmp = item.split("=");
			if (tmp[0] === parameterName) {
				result = (tmp[1] + '').replace(/\+/g, '%20');
				result = decodeURIComponent(result);
			}
		});
	if (result == null) {
		return defaultValue;
	} else {
		return result;
	}
}

function removeParam(sourceURL, key) {
	var rtn = sourceURL.split("?")[0],
		param,
		params_arr = [],
		queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
	if (queryString !== "") {
		params_arr = queryString.split("&");
		for (var i = params_arr.length - 1; i >= 0; i -= 1) {
			param = params_arr[i].split("=")[0];
			if (param === key) {
				params_arr.splice(i, 1);
			}
		}
		rtn = rtn + "?" + params_arr.join("&");
	}
	return rtn;
}

function startLoading() {
	$('body').addClass("ajax-loading");
}

function endLoading() {
	$('body').removeClass("ajax-loading");
}

function updateAreas(url, item) {
	$('.ajax-nav').collapse('hide');
	if (item != null) {
		$('.ajax-nav .nav-item').removeClass("active");
		$(item).parent().addClass("active");
		window.history.pushState($(item).attr("name"), $(this).attr("title"), $(item).attr("href"));
	}
	$.ajax({
		url: url,
		dataType: 'html',
		success: function (html) {
			var newHTML = document.createElement('html');
			newHTML.innerHTML = html;
			$('body').attr("class", newHTML.querySelector('body').className);
			if ($('body').data("areas") != null) {
				var areas = $('body').data("areas").split(',');
				for (var i = 0; i < areas.length; i++) {
					var area = newHTML.querySelector('#' + areas[i]);
					if (area != null) {
						$('#' + areas[i]).replaceWith(area.outerHTML);
					} else {
						$('#' + areas[i]).html("");
					}
				}
			} else {
				$('._area').each(function () {
					var area = newHTML.querySelector('#' + $(this).attr('id'));
					if (area != null) {
						$(this).replaceWith(area.outerHTML);
					} else {
						$(this).html("");
					}
				});
			}
			updateImg();
			ajaxNav();
			initCollapseLinkBootstrap(".collapse-link", false);
		}
	});
	return false;
}


function ajaxNav() {
	if (isPreview()) {
		return;
	}
	var links = $('.ajax-nav a');
	links.each(function () {
		var link = $(this);
		if (!link.hasClass("ajax-nav-done") && !link.attr("href").startsWith("http") && (link.attr("href").endsWith(".html") || link.attr("href").endsWith("/"))) {
			link.addClass("ajax-nav-done");
			link.click(function () {
				$('#wrapper').addClass('toggled');
				ajaxNavDone = true;
				return updateAreas(link.attr("href"), link);
			});
		}
	});
	var links = $('a.content-area-only');
	links.each(function () {
		var link = $(this);
		link.click(function () {
			$('a.content-area-only').removeClass("active");
			$(this).addClass("active");
			window.history.pushState($(this).attr("data-name"), $(this).attr("title"), $(this).attr("href"));
			$.ajax({
				url: link.attr("href"),
				data: 'only-area=content&only-area-wrapper=true',
				dataType: 'html',
				success: function (html) {
					$('#content').replaceWith(html);
					updateImg();
				}
			});
			return false;
		});
	});
}

function isEditPreview() {
	return $('.edit-preview').length > 0;
}

function isPreview() {
	return $('body.preview-logged').length > 0;
}

function copyTitle() {
	$('[data-gettitle]').each(function () {
		var container = $($(this).data('gettitle'));
		if (container.length == 0) {
			console.log("container not found : " + $(this).data('gettitle'));
		}
		var titles = container.find("h1");
		if (titles.length == 0) {
			titles = container.find("h2");
			if (titles.length == 0) {
				titles = container.find("h3");
			}
		}
		if (titles.length > 0) {
			$(this).html($(titles[0]).text());
		}
	});
}

function staticSearch() {
	var dataItem = jQuery('#staticSearchData');
	var buttonItem = jQuery('#staticSearchButton');
	var resultItem = jQuery('#staticSearchResult');
	if (dataItem.length > 0 && buttonItem.length > 0 && resultItem.length > 0) {
		var data = [];
		var dataReady = false;
		buttonItem.on("focus", function () {
			jQuery.ajax({
				dataType: "json",
				url: dataItem.attr('href'),
				success: function (json) {
					data = json;
					dataReady = true;
					console.log("json = ", json);
				}
			});
		});
		searchUpdate = function () {
			if (dataReady) {
				resultItem.html('');
				if (jQuery(this).val().length > 0) {

					result = search(jQuery(this).val(), data, 5);
					result.forEach(function (item) {
						if (item.description != null) {
							resultItem.append('<div class="search-item"><a href="' + item.url + '">' + item.title + '</a><p>' + item.description + '</p></div>');
						} else {
							resultItem.append('<div class="search-item"><a href="' + item.url + '">' + item.title + '</a></div>');
						}
					});
				}
			}
		};
		buttonItem.on("keyup", searchUpdate);
		buttonItem.on("paste", searchUpdate);
	}
}

function search(text, data, maxResult) {
	text = text.toLowerCase();
	var result = [];
	data.pages.forEach(function (item) {
		weight = 0;
		if (item.title != null && item.title.toLowerCase().indexOf(text) >= 0) {
			weight = 3;
		}
		if (item.description != null && item.description.toLowerCase().indexOf(text) >= 0) {
			weight = weight + 2;
		}
		if (item.content != null && item.content.toLowerCase().indexOf(text) >= 0) {
			weight = weight + 1;
		}
		if (weight > 0) {
			weight = weight + item.weight;
			page = { url: item.url, title: item.title, description: item.description, weight: weight };
			result.push(page);
		}
	});

	if (maxResult > result.length) {
		return result;
	}

	var bestResult = [];
	while (bestResult.length < maxResult) {
		bestWeight = -1;
		bestItem = null;
		result.forEach(function (item) {
			if (item.weight > bestWeight && bestResult.indexOf(item) == -1) {
				bestWeight = item.weight;
				bestItem = item;
			}
		});
		page = { url: bestItem.url, title: bestItem.title, description: bestItem.description, weight: bestItem.weight };
		bestItem.weight = 0;
		bestResult.push(page);
	}
	return bestResult;
}

function updateAjaxLinks() {
	jQuery(".ajax-group").parent().on("click", "a.ajax", function (event) {
		event.preventDefault();
		var delID = jQuery(this).data('deleteid');
		var doneFct = jQuery(this).data('done');
		ajaxRequest(jQuery(this).attr('href'), function () {
			if (delID != null) {
				jQuery("#" + delID).remove();
			}
			if (doneFct != null) {
				doneFct();
			}
		});
	});
}

function submitFormWithAjax(form, successFunction) {
	var data = $(this).serialize();
	$.ajax({
		url: $(form).attr('action'),
		type: $(form).attr('method'),
		data: data,
		success: successFunction
	});
	return false;
}

function ajaxSubmitForm(form, successFunction, json) {
	const params = new URLSearchParams();
	for (const pair of new FormData(form)) {
		params.append(pair[0], pair[1]);
	}
	if (json) {
		fetch(form.action, { body: params, method: 'post', 'Content-Type': 'text/plain; charset=UTF-8' })
			.then(response => {
				return response.json()
			})
			.then(data => {
				try {
					successFunction(data);
				} catch (error) {
					successFunction();
				}
			});
	} else {
		fetch(form.action, { body: params, method: 'post', 'Content-Type': 'text/plain; charset=UTF-8' })
			.then(response => {
				successFunction(response.text());
			})
	}
}

function executeFunctionByName(functionName, context, args ) {
	var args = Array.prototype.slice.call(arguments, 2);
	var namespaces = functionName.split(".");
	var func = namespaces.pop();
	for(var i = 0; i < namespaces.length; i++) {
	  context = context[namespaces[i]];
	}
	return context[func].apply(context, args);
  }

function updateAjaxForms() {	
	$("form.ajax-form").each(function () {
		var form = this;
		$(this).submit(function (e) {
			var data = $(this).serialize();
			var requestType = "json";
			if ($(form).data("type") != null) {
				requestType = $(form).data("type");
			}
			var event = e;
			e.stopPropagation();
			$.ajax({
				url: $(this).attr('action'),
				method: $(this).attr('method'),
				type: requestType,
				data: data,
				success: function (json) {					
					var functionName = $(form).data('onsubmit');
					if (functionName != null) {
						executeFunctionByName(functionName, window, json);
					} else {
						console.log("json:",json);
						ajaxDoneDefaultFunction(json);
					}
					event.stopPropagation();
					return false;
				}
			});
			
			return false;
		});
	});
}

/** * FONCTIONS ** */

updateImg = function () {
	jQuery("img[data-src]").each(function () {
		jQuery(this).attr('src', jQuery(this).data('src'));
		jQuery(this).removeAttr('data-src');
	});
}

ajaxRequest = function (url, doneFunction) {
	if (url.indexOf("/edit-") >= 0) {
		url = url.replace("/edit-", "/ajax-");
	} else {
		url = url.replace("/edit/", "/ajax/");
		if (url.indexOf("/preview-") >= 0) {
			url = url.replace("/preview-", "/ajax-");
		} else {
			url = url.replace("/preview/", "/ajax/");
		}
	}
	var data = null;
	jQuery("body").addClass("ajax-loading");
	jQuery.ajax({
		url: url,
		cache: false,
		data: data,
		type: "post",
		dataType: "json"
	}).done(
		function (jsonObj) {
			ajaxDoneDefaultFunction(jsonObj, doneFunction);
		});
}

ajaxDoneDefaultFunction = function (jsonObj, doneFunction) {
	jQuery("body").removeClass("ajax-loading");
	if (jsonObj.data != null) {
		if (jsonObj.data["need-refresh"]) {
			reloadPage();
		}
	}
	jQuery.each(jsonObj.zone, function (xhtmlId, xhtml) {
		if (xhtmlId.indexOf("#") < 0 && xhtmlId.indexOf(" ") < 0) {
			xhtmlId = "#" + xhtmlId;
		}

		var item = jQuery(xhtmlId);
		if (item != null) {
			jQuery(xhtmlId).replaceWith(xhtml);
		} else {
			jQuery.each(jsonObj.data, function (key, value) {
			});
			if (console) {
				console.log("warning : component " + xhtmlId
					+ " not found for zone.");
			}
		}
	});
	jQuery.each(jsonObj.insideZone, function (xhtmlId, xhtml) {
		if (xhtmlId.indexOf("#") < 0 && xhtmlId.indexOf(".") < 0
			&& xhtmlId.indexOf(" ") < 0) {
			xhtmlId = "#" + xhtmlId;
		}
		var item = jQuery(xhtmlId);
		if (item != null) {
			item.html(xhtml);
		} else {
			if (console) {
				console.log("warning : component " + xhtmlId
					+ " not found for insideZone.");
			}
		}
	});
	if (doneFunction != null) {
		doneFunction(jsonObj);
	}
	jQuery(document).trigger("ajaxUpdate");
	updateImg();
}

reloadPage = function () {
	var doc = document.documentElement, body = document.body;
	var topScroll = (doc && doc.scrollTop || body && body.scrollTop || 0);
	var currentURL = window.location.href;
	if (currentURL.indexOf("_scrollTo") >= 1) {
		currentURL = currentURL.substring(0,
			currentURL.indexOf("_scrollTo") - 1);
	}
	if (currentURL.indexOf("?") < 0) {
		currentURL = currentURL + "?" + "_scrollTo=" + topScroll;
	} else {
		currentURL = currentURL + "&" + "_scrollTo=" + topScroll;
	}
	window.location.href = currentURL;
}

document.addEventListener("DOMContentLoaded", function (event) {
	var elementPosition = $('#fixed-box').offset();
	var elementWidth = $('#fixed-box').outerWidth();
	if (typeof autosize === "function") {
		autosize(document.querySelectorAll('textarea.autosize'));
	}
	updateImg();
	$(window).scroll(function () {
		if ($(window).scrollTop() > 30) {
			$("body").addClass("scrolled");
		} else {
			$("body").removeClass("scrolled");
		}
		if (screen.width >= 640 && elementPosition != null) {
			if ($(window).scrollTop() > elementPosition.top) {
				$('#fixed-box').css('position', 'fixed').css('top', '5px');
				$('#fixed-box').css('width', elementWidth + "px");
			} else {
				$('#fixed-box').css('position', 'static');
			}
		}
		$("[data-maxtop]").each(function () {
			var item = $(this);
			var topItem = $(item.data("maxtop"));
			if (topItem.data('initTop') == null) {
				topItem.data('initTop', item.position().top);
			}
			var maxtop = topItem.outerHeight() + topItem.position().top;
			var itemtop = topItem.data('initTop') - $(window).scrollTop();
			if (itemtop < maxtop) {
				item.css("position", "fixed");
				item.css("top", maxtop + "px");
				item.css("width", "100%");
				item.css("z-index", "1");
			} else {
				item.css("position", "static");
			}
		});
	});
	$(window).scroll(function () {
		var scroolTop = $(window).scrollTop();
		navbar = $(".navbar.fixed-top");
		well = $("#header .well");
		if (!smallDevice() && navbar.length > 0 && well.length > 0) {
			wellpos = well.data('base-offset') - scroolTop;
			if (wellpos <= navbar.outerHeight() + 1) {
				well.css('position', 'fixed');
				well.css('top', navbar.outerHeight());
				well.css('width', "100%");
				well.css('z-index', "2");
			} else {
				well.css('position', 'static');
			}
		}
		if (screen.width >= 640 && elementPosition != null) {
			if ($(window).scrollTop() > elementPosition.top) {
				$('#fixed-box').css('position', 'fixed').css('top', '5px');
				$('#fixed-box').css('width', elementWidth + "px");
			} else {
				$('#fixed-box').css('position', 'static');
			}
		}
		var viewportHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
		jQuery("section.parallax").each(function () {
			if (elementInViewport(this)) {
				var section = jQuery(this);
				var offset = section.offset();
				if (offset.top - scroolTop < viewportHeight) {
					var margin = Math.round((scroolTop - offset.top) / 4);
					section.find('.background-image img').css("margin-top", margin);
				}
			}
		});
	});
	$(window).scroll(function () {
		$(".paralax-container").each(function () {
			var paralax = $(this);
			paralax.css("margin-top", Math.round($(this).scrollTop() / 1.5) + "px");
			paralax.height(paralax.height - $(this).scrollTop() + "px");

		});
	});
	$(window).on('resize', function () {
		modalImageHeight();
	});
	if (typeof jQuery.daterangepicker !== 'undefined' && $.isFunction(jQuery.daterangepicker)) {
		jQuery(window).load(function () {
			jQuery('.daterange').daterangepicker({
				format: 'DD/MM/YYYY',
				showDropdowns: true,
				showWeekNumbers: true
			});
		});
	}
	jQuery(window).on("load", function () {
		if (typeof autosize === "function") {
			autosize(document.querySelectorAll('textarea.autosize'));
		}
		stayOnTop();
	});

	/** counter **/
	(function ($) {
		$.fn.countTo = function (options) {
			options = options || {};

			return $(this).each(function () {
				// set options for current element
				var settings = $.extend({}, $.fn.countTo.defaults, {
					from: $(this).data('from'),
					to: $(this).data('to'),
					speed: $(this).data('speed'),
					refreshInterval: $(this).data('refresh-interval'),
					decimals: $(this).data('decimals')
				}, options);

				// how many times to update the value, and how much to increment the value on each update
				var loops = Math.ceil(settings.speed / settings.refreshInterval),
					increment = (settings.to - settings.from) / loops;

				// references & variables that will change with each update
				var self = this,
					$self = $(this),
					loopCount = 0,
					value = settings.from,
					data = $self.data('countTo') || {};

				$self.data('countTo', data);

				// if an existing interval can be found, clear it first
				if (data.interval) {
					clearInterval(data.interval);
				}
				data.interval = setInterval(updateTimer, settings.refreshInterval);

				// initialize the element with the starting value
				render(value);

				function updateTimer() {
					value += increment;
					loopCount++;

					render(value);

					if (typeof (settings.onUpdate) == 'function') {
						settings.onUpdate.call(self, value);
					}

					if (loopCount >= loops) {
						// remove the interval
						$self.removeData('countTo');
						clearInterval(data.interval);
						value = settings.to;

						if (typeof (settings.onComplete) == 'function') {
							settings.onComplete.call(self, value);
						}
					}
				}

				function render(value) {
					var formattedValue = settings.formatter.call(self, value, settings);
					$self.html(formattedValue);
				}
			});
		};

		$.fn.countTo.defaults = {
			from: 0,               // the number the element should start at
			to: 0,                 // the number the element should end at
			speed: 1000,           // how long it should take to count between the target numbers
			refreshInterval: 100,  // how often the element should be updated
			decimals: 0,           // the number of decimal places to show
			formatter: formatter,  // handler for formatting the value before rendering
			onUpdate: null,        // callback method for every time the element is updated
			onComplete: null       // callback method for when the element finishes updating
		};

		function formatter(value, settings) {
			return value.toFixed(settings.decimals);
		}
	}(jQuery));

	jQuery(function ($) {
		jQuery(".carousel").each(function () {
			this.addEventListener('touchstart', handleTouchStart, false);
			this.addEventListener('touchmove', handleTouchMove, false);
		});

		jQuery('.js-scroll-trigger').click(function () {
			jQuery('.navbar-collapse').collapse('hide');
		});
	});

	/** counter **/

	(function ($) {
		$.fn.countTo = function (options) {
			options = options || {};

			return $(this).each(function () {
				// set options for current element
				var settings = $.extend({}, $.fn.countTo.defaults, {
					from: $(this).data('from'),
					to: $(this).data('to'),
					speed: $(this).data('speed'),
					refreshInterval: $(this).data('refresh-interval'),
					decimals: $(this).data('decimals')
				}, options);

				// how many times to update the value, and how much to increment the value on each update
				var loops = Math.ceil(settings.speed / settings.refreshInterval),
					increment = (settings.to - settings.from) / loops;

				// references & variables that will change with each update
				var self = this,
					$self = $(this),
					loopCount = 0,
					value = settings.from,
					data = $self.data('countTo') || {};

				$self.data('countTo', data);

				// if an existing interval can be found, clear it first
				if (data.interval) {
					clearInterval(data.interval);
				}
				data.interval = setInterval(updateTimer, settings.refreshInterval);

				// initialize the element with the starting value
				render(value);

				function updateTimer() {
					value += increment;
					loopCount++;

					render(value);

					if (typeof (settings.onUpdate) == 'function') {
						settings.onUpdate.call(self, value);
					}

					if (loopCount >= loops) {
						// remove the interval
						$self.removeData('countTo');
						clearInterval(data.interval);
						value = settings.to;

						if (typeof (settings.onComplete) == 'function') {
							settings.onComplete.call(self, value);
						}
					}
				}

				function render(value) {
					var formattedValue = settings.formatter.call(self, value, settings);
					$self.html(formattedValue);
				}
			});
		};

		$.fn.countTo.defaults = {
			from: 0,               // the number the element should start at
			to: 0,                 // the number the element should end at
			speed: 1000,           // how long it should take to count between the target numbers
			refreshInterval: 100,  // how often the element should be updated
			decimals: 0,           // the number of decimal places to show
			formatter: formatter,  // handler for formatting the value before rendering
			onUpdate: null,        // callback method for every time the element is updated
			onComplete: null       // callback method for when the element finishes updating
		};

		function formatter(value, settings) {
			return value.toFixed(settings.decimals);
		}
	}(jQuery));

	jQuery(function ($) {
		// start all the timers
		$('.count-number').each(count);

		function count(options) {
			var $this = $(this);
			options = $.extend({}, options || {}, $this.data('countToOptions') || {});
			$this.countTo(options);
		}
	});
});

function elementInViewport(el) {
	var top = el.offsetTop;
	var left = el.offsetLeft;
	var width = el.offsetWidth;
	var height = el.offsetHeight;

	while (el.offsetParent) {
		el = el.offsetParent;
		top += el.offsetTop;
		left += el.offsetLeft;
	}

	return (
		top < (window.pageYOffset + window.innerHeight) &&
		left < (window.pageXOffset + window.innerWidth) &&
		(top + height) > window.pageYOffset &&
		(left + width) > window.pageXOffset
	);
}

function smallDevice() {
	return $(window).width() < 720;
};

function scrollTo(select) {
	if (jQuery(select).length > 0) {
		jQuery('html, body').animate({
			scrollTop: jQuery(select).offset().top - 25
		}, 500);
	}
}

function toBootstrap(item) {
	var mainItem = jQuery(item);
	mainItem.find("button").each(function () {
		jQuery(this).addClass("btn btn-default");
	});
}

function modalImageHeightItem(img) {
	$(img).css('max-height', $(window).height() - 10);
	$(img).parent().css('height', $(window).height() - 10);
}

function modalImageHeight() {
	jQuery(".modal-full img").each(function () {
		modalImageHeightItem($(this));
	});
	jQuery(".modal-lg img").each(function () {
		var modal = $(this).parent().parent().parent().parent().parent();
		if (modal.hasClass('in')) {
			var modalTop = 65;
			var height = $(window).height() - modal.find('.caption').outerHeight() - modal.find('.modal-header').outerHeight() - modalTop - 75 - 15;
			$(this).css('max-height', height);
		} else {
			$(this).css('max-height', "none");
		}
		$(this).parent().css('height', "auto");
	});
}

function askFullscreen() {
	var elem = document.getElementsByTagName("body")[0];
	if (elem.requestFullscreen) {
		elem.requestFullscreen();
	} else if (elem.msRequestFullscreen) {
		elem.msRequestFullscreen();
	} else if (elem.mozRequestFullScreen) {
		elem.mozRequestFullScreen();
	} else if (elem.webkitRequestFullscreen) {
		elem.webkitRequestFullscreen();
	}
}

function cancelFullScreen() {
	if (document.cancelFullScreen) {
		document.cancelFullScreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.webkitCancelFullScreen) {
		document.webkitCancelFullScreen();
	} else if (document.msCancelFullScreen) {
		document.msCancelFullScreen();
	}
}

/** slide show **/

function createSlideshow(containerSelector, rowSelector, itemsSelector, itemSizerSelector) {
	var AUTO_NEXT_TIME = 7000;
	var currentIndex = 0;
	var intervalId = null;

	var container = $(containerSelector);
	//Si la couche row n'existe pas, il faudrait la créer en JS
	var row = container.find(rowSelector);
	row.css({ width: 99999 });

	container.mouseenter(function () {
		schedule(false);
	});
	container.mouseleave(function () {
		schedule(true);
	});
	schedule(true);

	function schedule(set) {
		if (intervalId != null) {
			clearInterval(intervalId);
			intervalId = null;
		}
		if (set) {
			intervalId = setInterval(next, AUTO_NEXT_TIME);
		}
	}

	function next() {
		currentIndex++;
		var backup = currentIndex;
		update();
		return backup == currentIndex;
	}
	function previous() {
		currentIndex--;
		var backup = currentIndex;
		update();
		return backup == currentIndex;
	}
	function update() {
		var maxIndex = computeMaxIndex();
		if (currentIndex > maxIndex) {
			currentIndex = maxIndex;
		}
		if (currentIndex < 0) {
			currentIndex = 0;
		}
		var x = 0;
		var items = row.find(itemsSelector);
		items.each(function (i) {
			if (i < currentIndex) {
				x += $(this).find(itemSizerSelector).outerWidth(true);
			}
		});
		row.css({ marginLeft: -x });
		return currentIndex;
	}
	function computeMaxIndex() {
		var items = row.find(itemsSelector);
		var viewPortWidth = container.innerWidth();
		var maxIndex = null;
		items.each(function (i) {
			var remainingWidth = 0;
			items.each(function (j) {
				if (j >= i) {
					remainingWidth += $(this).find(itemSizerSelector).outerWidth(true);
				}
			});
			if (maxIndex == null && (remainingWidth <= viewPortWidth)) {
				maxIndex = i;
			}
		});
		if (maxIndex == null) {
			maxIndex = items.length - 1;
		}
		return maxIndex;
	}
	return {
		next: next,
		previous: previous,
	}
}

function stayOnTop() {
	if ($('.stay_on_top').length > 0) {
		var sticky_navigation_offset_top = $('.stay_on_top').offset().top;
		var sticky_navigation = function () {
			var scroll_top = $(window).scrollTop();
			if (scroll_top > sticky_navigation_offset_top) {
				$('.stay_on_top').css({ 'width': $('.stay_on_top').outerWidth() + 'px' });
				$('.stay_on_top').addClass("top_fixed");
			} else {
				$('.stay_on_top').css({ 'width': $('.stay_on_top').data("width") });
				$('.stay_on_top').removeClass("top_fixed");
			}
		};
		sticky_navigation();
		$(window).scroll(function () {
			sticky_navigation();
		});
	}
};

/*** swipe ***/

var xDown = null;
var yDown = null;

function handleTouchStart(evt) {
	xDown = evt.touches[0].clientX;
	yDown = evt.touches[0].clientY;
};

function handleTouchMove(evt) {
	if (!xDown || !yDown) {
		return;
	}

	var xUp = evt.touches[0].clientX;
	var yUp = evt.touches[0].clientY;

	var xDiff = xDown - xUp;
	var yDiff = yDown - yUp;

	if (Math.abs(xDiff) > Math.abs(yDiff)) {/*most significant*/
		if (xDiff > 0) {
			$(this).carousel('next');
		} else {
			$(this).carousel('prev');
		}
	}
	xDown = null;
	yDown = null;
};

function clone(obj) {
	if (null == obj || "object" != typeof obj) return obj;
	var copy = obj.constructor();
	for (var attr in obj) {
		if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
	}
	return copy;
}

function onSubmitMailSend(prefix, msg) {
	alert(msg);
	$('#' + prefix + 'create-account-with-email-form').html('<div class="alert alert-primary" role="alert">' + msg + '</div>');
}

function setDomData(key, value) {
	var items = document.getElementsByClassName("dt-" + key);
	for (var i = 0; i < items.length; i++) {
		items[i].innerHTML = value;
	}
}

function copyBtn(btn) {
	var ta = document.createElement('textarea');
	if (btn.dataset.text != null) {
		ta.value = btn.dataset.text;
	} else {
		var item = document.getElementById(btn.dataset.id);
		if (item == null) {
			console.error("id not found : "+btn.dataset.id);
			return false;
		} else {
			ta.value = item.textContent;
		}
	}
	ta.setAttribute('readonly', '');
	ta.style = { position: 'absolute', left: '-9999px' };
	document.body.appendChild(ta);
	ta.select();
	document.execCommand('copy');
	document.body.removeChild(ta);
	return false;
}

function dateForInput(date) {
	var day = ("0" + date.getDate()).slice(-2);
	var month = ("0" + (date.getMonth() + 1)).slice(-2);
	return date.getFullYear()+"-"+(month)+"-"+(day) ;
}

function nextDay(input) {
	if (input.valueAsDate !== null) {	
		var date = new Date();
		date.setDate(input.valueAsDate.getDate() + 1);
		input.value = dateForInput(date);
	}
}

function previousDay(input) {
	if (input.valueAsDate !== null) {
		var date = new Date();
		date.setDate(input.valueAsDate.getDate() - 1);
		input.value = dateForInput(date);
	}
}

function displayIfTrue() {	
	document.querySelectorAll("[data-displayiftrue]").forEach(function(item) {
		var target = document.querySelector(item.dataset.displayiftrue);
		//console.log(target);
		if (target != null) {
			if (target.visibleOnTrue == null) {
				target.visibleOnTrue = [];
			}
			target.visibleOnTrue.push(item);
			if (target.value == "1" || target.value=="true" || target.value=="on" || target.value=="yes") {
				item.classList.remove("hidden");
				item.querySelectorAll("input,select,textarea").forEach(function(inputItem) {
					inputItem.required = true;
				});
			} else {
				item.classList.add("hidden"); 
				item.querySelectorAll("input,select,textarea").forEach(function(inputItem) {
					inputItem.required = false;
				});
			}
			target.onchange = function() {				
				var selectValue = this.value;
				this.visibleOnTrue.forEach(function(item) {
					if (selectValue == "1" || selectValue=="true" || selectValue=="on" || selectValue=="yes") {
						item.classList.remove("hidden");
						item.querySelectorAll("input,select,textarea").forEach(function(inputItem) {						
							inputItem.required = true;
						});
					} else {
						item.classList.add("hidden");
						item.querySelectorAll("input,select,textarea").forEach(function(inputItem) {
							inputItem.required = false;
						});
					}
				});
			}
		}
	});
}


/** PARALAX src: https://speckyboy.com/10-css-javascript-parallax-scrolling-code-snippets/ **/

function initParallax() {
	$('.img-parallax').each(function(){
	var img = $(this);
	var imgParent = $(this).parent();
	function parallaxImg () {
		var speed = img.data('speed');
		if (speed == null) {
			speed = -1;
		}
		var imgY = imgParent.offset().top;
		var winY = $(this).scrollTop();
		var winH = $(this).height();
		var parentH = imgParent.innerHeight();

		// The next pixel to show on screen      
		var winBottom = winY + winH;

		// If block is shown on screen
		if (winBottom > imgY && winY < imgY + parentH) {
		// Number of pixels shown after block appear
		var imgBottom = ((winBottom - imgY) * speed);
		// Max number of pixels until block disappear
		var imgTop = winH + parentH;
		// Porcentage between start showing until disappearing
		var imgPercent = ((imgBottom / imgTop) * 100) + (50 - (speed * 50));
		}
		img.css({
		top: imgPercent + '%',
		transform: 'translate(-50%, -' + imgPercent + '%)'
		});
	}
	parallaxImg();
	$(document).on({
		scroll: function () {
		parallaxImg();
		}
	});
	});
	// var paraImages = document.querySelectorAll('.img-parallax');
  //   new simpleParallax(paraImages); 
}

/**
 * init collapse bootstrap 
 */

 function initCollapseBootstrap(cssQuery) {
    document.querySelectorAll(cssQuery).forEach(function(title, index) {

        id = "_collapse-title-"+(index+1);
        link = document.createElement("a");
        link.setAttribute("class", "collapse-title-action");
        link.setAttribute("data-toggle", "collapse");
        link.setAttribute("href", "#"+id);
        link.setAttribute("role", "button");
        link.setAttribute("aria-expanded", "false");
        link.setAttribute("aria-controls", id);
        display = document.createElement("span");
        display.setAttribute('class', 'collpase-title-arrow');
        title.innerHTML  = '<i class="fas fa-angle-right collapse-on"></i><i class="fas fa-angle-down collapse-off"></i>&nbsp;'+title.innerHTML;

        sister = title.nextSibling;
        wrap(title, link);
        wrap(title, display);

        collapseDiv = document.createElement("div");
        collapseDiv.setAttribute("id", id);
        collapseDiv.setAttribute("class", "collapse collapse-title-target");
        
        while (sister != null && sister.nodeName != title.nodeName) {
            oldSister = sister;
            sister = sister.nextSibling;
            wrap(oldSister, collapseDiv);
        }
    });
    $(cssQuery).collapse();
}

function wrap(el, wrapper) {
    el.parentNode.insertBefore(wrapper, el);
    wrapper.appendChild(el);
}

function getBody(content) {
    var x = content.indexOf("<body");
    x = content.indexOf(">", x);
    var y = content.lastIndexOf("</body>");
    return content.slice(x + 1, y);
}

function initCollapseLinkBootstrap(cssQuery, arrow) {
    document.querySelectorAll(cssQuery).forEach(function (link, index) {
		link.classList.add("hidden");
		closePopup,
        id = "_collapse-link-" + (index + 1);

        url = link.getAttribute("href")+'?only-area=content';

		link.classList.add("collapse-link-action");
        link.setAttribute("data-toggle", "collapse");
        link.setAttribute("href", "#" + id);
        link.setAttribute("role", "button");
        link.setAttribute("aria-expanded", "false");
        link.setAttribute("aria-controls", id);
        if (arrow) {
            display = document.createElement("span");
            display.setAttribute('class', 'collpase-link-arrow');
            link.innerHTML = '<i class="fas fa-angle-right collapse-on"></i><i class="fas fa-angle-down collapse-off"></i>&nbsp;' + link.innerHTML;
        }

        if (arrow) {
            wrap(link, display);
        }

        let xhr = new XMLHttpRequest();
        xhr.open("GET", url);
		xhr.responseType = "html";        
		xhr.htmlId = id;
		xhr.linkNode = link;
		xhr.send();
        xhr.onload = function () {            
            if (xhr.status != 200) {                
                alert("Erreur " + xhr.status + " : " + xhr.statusText);                
            } else {
				collapseDiv = document.createElement("div");
        		collapseDiv.setAttribute("id", this.htmlId);
        		collapseDiv.setAttribute("class", "collapse collapse-title-target");
				collapseDiv.innerHTML=getBody(xhr.response);
				collapseDiv.querySelectorAll("a.reverse-link").forEach(function(link) {
					$(link).click(function() {
						var url = $(this).attr("href");
						url = addParam(window.location.href, POPUPURLNAME + '=' + url);
						window.history.pushState("popup", $(this).attr("title"), url);
						openPopup($(this).attr("title"), $(this).attr("href"));
						return false;
					});
				});
				this.linkNode.parentNode.parentNode.parentNode.insertBefore(collapseDiv, this.linkNode.parentNode.parentNode.nextSibling);
				this.linkNode.classList.remove("hidden");
            }
		};		

    });
    $(cssQuery).collapse();
}