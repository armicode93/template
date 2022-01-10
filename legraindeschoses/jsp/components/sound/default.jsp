<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<script>
	String.prototype.replaceAll = function(search, replacement) {
		var target = this;
		return target.split(search).join(replacement);
	};

	var NEED_INIT = true;

	function initPosition(sound) {
		if (NEED_INIT) {
			var userTime = getCookie(sound.src);
			if (userTime != null) {
				sound.currentTime = userTime;
				//sound.play();
			}
			NEED_INIT = false;
		}
	};

	function findGetParameter(parameterName) {
		var result = null, tmp = [];
		location.search.substr(1).split("&").forEach(function(item) {
			tmp = item.split("=");
			if (tmp[0] === parameterName)
				result = decodeURIComponent(tmp[1]);
		});
		return result;
	}

	/**********************************
	 * COOKIES
	 */

	function setCookie(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = encodeCookie(cname) + "=" + cvalue + ";" + expires
				+ ";path=/";
	}

	function encodeCookie(cname) {
		return encodeURI(cname.replaceAll("/", "_"));
	}

	function getCookie(cname) {
		var name = encodeCookie(cname) + "=";
		var decodedCookie = decodeURIComponent(document.cookie);
		var ca = decodedCookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) == 0) {
				return c.substring(name.length, c.length);
			}
		}
		return "";
	}

	function deleteCookie(cname) {
		document.cookie = encodeURI(cname)
				+ '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
	}

	function storeCookie() {
		var music = document.getElementById('native_audio_player');
		if (music.currentSrc != null) {
			setCookie("morceau", music.getAttribute("src"), 365);
			setCookie(music.currentSrc, music.currentTime, 365);
		}
	}

	function restoreCookiePosition() {
		var music = document.getElementById('native_audio_player');
		var pos = getCookie(music.currentSrc);
		if (pos != null) {
			music.pause();
			music.currentTime = pos;
			music.play();
		}
	}

	/**********************************
	 * CHAPTERS
	 */

	var currentSound = 1;

	function selectChapter(number, restoreCookie, sommaireURL) {
		
		console.log("selectChapter=",number," sommaireURL="+sommaireURL);

		currentSound = number;

		if (sommaireURL != null) {
			loadSommaire(sommaireURL);
		}
		var chapters = document.querySelectorAll(".chapter-command");
		var item = document.getElementById('sound-' + number);
		if (item == null) {
			console.log("sound not found : " + number);
			return;
		}

		if (chapters != null) {
			for (i = 0; i < chapters.length; i++) {
				chapters[i].classList.remove("active");
			}
		}
		var url = item.getAttribute("data-url");
		var title = item.getAttribute("data-title");
		var position = item.getAttribute("data-position");
		var music = document.getElementById('native_audio_player');
		var musicSrc = document.getElementById('native_audio_player_src');

		if (title != null) {
			document.getElementById('sound-title').innerHTML = title;
		}
		music.pause();
		if (restoreCookie) {
			music.onloadstart = function() {
				restoreCookiePosition();
			}
		} else {
			music.onloadstart = null;
		}
		if (!musicSrc.src.endsWith(url)) {
			music.pause();
			music.src = url;
			music.load();
			music.currentTime = position;
			console.log("play 1");
			music.play();
		} else {
			music.currentTime = position;
			console.log("play 2");
			music.play();
		}
		frame();
	}

	function changeSound(next) {
		if (next) {
			currentSound++;
			soundItemId = "sound-" + currentSound;
			if (document.getElementById("sound-" + currentSound) == null) {
				currentSound = 1;
			}
		} else {
			currentSound = currentSound - 1;
			if (currentSound < 1) {
				currentSound = 1;
			}
		}
		selectChapter(currentSound, false);
	}

	/***************************
	 * manage player 
	 */

	function displayTime(time) {
		if (time == null) {
			return "00:00:00";
		}
		var sec = "" + Math.round(time) % 60;
		var min = "" + Math.trunc(time / 60) % 60;
		var hour = "" + Math.trunc(time / (60 * 60));
		if (sec.length == 1) {
			sec = "0" + sec;
		}
		if (min.length == 1) {
			min = "0" + min;
		}
		if (hour.length == 1) {
			hour = "0" + hour;
		}
		var outTime = hour + ":" + min + ":" + sec;
		if (outTime.indexOf("N") >= 0) {
			return "";
		} else {
			return outTime;
		}
	}

	function frame() {
		var music = document.getElementById('native_audio_player');
		if (!music.paused) {
			storeCookie();
			pButton.className = "";
			pButton.className = "pause";
		} else {
			pButton.className = "";
			pButton.className = "play";
		}
		if (music.readyState > 0) {
			document.getElementById('start-time').innerHTML = displayTime(music.currentTime);
			document.getElementById('end-time').innerHTML = displayTime(music.duration);
		}
		size = (music.currentTime / music.duration) * 100;
		track.style.width = size + '%';
		var command = document.getElementById('sound-command-' + currentSound);
		if (command != null) {
			command.classList.add("active");
		}
	}

	function onEnded() {
		var music = document.getElementById('native_audio_player');
		setCookie(music.currentSrc, 0, 365);
		changeSound(true);
		setCookie(music.currentSrc, 0, 365);
	}

	function playAudio() {
		var music = document.getElementById('native_audio_player');
		if (music.paused) {
			music.play();
		} else {
			music.pause();
		}
	}

	function firstLoad() {
		var music = document.getElementById('native_audio_player');
		var track = document.getElementById('track');
		var timeline = document.getElementById('timeline');
		timeline.addEventListener("click", function(e) {
			var rect = this.getBoundingClientRect();
			music.currentTime = (e.clientX - rect.left)
					/ (rect.right - rect.left) * music.duration;
		});
		music.onended = onEnded;
		var id = setInterval(frame, 100);
		var morceau = getCookie("morceau");
		if (morceau != null && morceau.length > 0) {
			NEED_INIT = true;
			var mus = document.querySelector("[data-url='" + morceau + "']");
			if (mus != null) {
				selectChapter(mus.getAttribute("data-number"), true);
			}
		} else {
			var mus = document.querySelectorAll(".chapter-data");
			console.log("mus = ", mus)
			if (mus.length > 0) {
				//console.log("number="+mus[0].getAttribute("data-number"));
				selectChapter(mus[0].getAttribute("data-number"), true);
			} else {
				console.log("no chapters found.");
			}
		}
	};
</script>
<div style="display: none;">
	<audio controls="controls" id="native_audio_player" preload="metadata">
		<source id="native_audio_player_src" src="${url}" type="${type}" />
		Your browser does not support the audio element.
	</audio>
</div>

<c:if test="${not empty summaryUrl}">
	<div id="sound-summary-wrapper" class="collapse">
		<div id="sound-summary" class="container">
			<div id="sound-summary-content"></div>
		</div>
	</div>
	<script>
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4) {
				document.getElementById("sound-summary-content").innerHTML = xhttp.responseText;
			}
		};
		xhttp.open("GET", "${summaryUrl}", true);
		xhttp.send();
	</script>
</c:if>
<c:if test="${not empty summaryUrl}">
	<div id="btn-summary">
		<a class="btn btn-secondary btn-sm" data-toggle="collapse" href="#sound-summary-wrapper" role="button" aria-expanded="false" aria-controls="sound-summary-wrapper"> <i class="fas fa-angle-double-up collapse-on"></i><i class="fas fa-angle-double-down collapse-off"></i> Sommaire <i class="fas fa-angle-double-up collapse-on"></i><i class="fas fa-angle-double-down collapse-off"></i>
		</a>
	</div>
</c:if>
<div id="sound-player" class="sound-player ajax-nav">
	<div id="audioplayer" class="audioPlayer">
		<div id="timeline" class="timeline">
			<div class="played" id="track"></div>
		</div>
		<div class="command">
			<button id="prevButton" class="previous" onclick="changeSound(false)" title="morceau precedant">
				<img src="${info.rootTemplateURL}/img/left.png" />
			</button>
			<button id="pButton" class="play" onclick="playAudio()" title="jouer le morceau">&nbsp;</button>
			<button id="nextButton" class="next" onclick="changeSound(true)" title="morcceau suivant">
				<img src="${info.rootTemplateURL}/img/right.png" />
			</button>
		</div>
	</div>
	<div class="time start-time" id="start-time"></div>
	<div class="time end-time" id="end-time"></div>
	<div class="title-block row">
		<div class="col-md-12 text-center">
			<div id="sound-title" class="titlee">${staticInfoHTML}</div>
		</div>
	</div>
	<div class="row">
		<div class="col-6 text-left">
			<a href="<jv:pageurl name='soutenir'/>">Souscrire</a>
		</div>
		<div class="col-6 text-right">
			<a href="<jv:pageurl name='sommaires'/>" id="sommaire-link">Sommaires</a>
		</div>
	</div>

	<div id="sommaire" style="display: none;"></div>
	<script>
	
		<c:if test="${not empty info.parent && info.parent.name=='sommaires'}">
			<jv:pageurl var="localSommaireURL" name='${info.pageName}' />
			<c:url var="localSommaireURL" value="${localSommaireURL}" context="/">
				<c:param name="only-area" value="content" />
				<c:param name="sommaire" value="true" />
				</c:url>
			/* page name = ${info.pageName} */
			var localSommaireURL = '${localSommaireURL}';
		</c:if>
		<c:set var="sommaireURL" value='${JvsommaireURL}' scope="session" />
	
		<c:if test="${empty sommaireURL}">
		<jv:pageurl var="JvsommaireURL" name='sommaires-3' />
		<c:if test="${fn:indexOf(info.pageName, 'sommaire') >= 0}">
			<jv:pageurl var="JvsommaireURL" name='${info.pageName}' />
		</c:if>
		<c:set var="sommaireURL" value='${JvsommaireURL}' scope="session" />
		</c:if>
		<c:url var="sommaireURL" value="${sommaireURL}" context="/">
		<c:param name="only-area" value="content" />
		<c:param name="sommaire" value="true" />
		</c:url>	
		
		var currentSommaireURL = "";
		function loadSommaire(sommaireURL) {
			if (sommaireURL == currentSommaireURL) {
				return;
			}
			console.log("load sommaireURL = ",sommaireURL);
			currentSommaireURL = sommaireURL;
			$.ajax({
				url : sommaireURL,
				cache : false,
				async : false,
				type : "get"
			}).done(function(html) {
				document.getElementById("sommaire").innerHTML = html;
				firstLoad();
			});
		}
		
		var soundToPlay = findGetParameter("play");
		if (soundToPlay != null) {
			console.log("soundToPlay = "+soundToPlay);
			selectChapter(soundToPlay, false, localSommaireURL);
			var music = document.getElementById('native_audio_player');
			music.play();
		} else {			
			loadSommaire('${sommaireURL}');
		}

		document.addEventListener("DOMContentLoaded", function(event) {
		});
	</script>

</div>
