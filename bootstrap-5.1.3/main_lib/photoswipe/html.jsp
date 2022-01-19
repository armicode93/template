<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><c:if test="${empty _pswpInsered}"><c:set var="_pswpInsered" value="true" scope="request" />

<script>
	function loadPhotoswipeCSS() {
		var head = document.getElementsByTagName('head')[0];
		var cssId = 'photoswipeBasicCss'; // you could encode the css path itself to generate id..
		if (!document.getElementById(cssId)) {
			var link = document.createElement('link');
			link.id = cssId;
			link.rel = 'stylesheet';
			link.type = 'text/css';
			link.href = '${info.rootTemplateURL}/main_lib/photoswipe/css/photoswipe.css';
			link.media = 'all';
			head.appendChild(link);
		}
		var cssId = 'photoswipeBasicSkin'; // you could encode the css path itself to generate id..
		if (!document.getElementById(cssId)) {
			var link = document.createElement('link');
			link.id = cssId;
			link.rel = 'stylesheet';
			link.type = 'text/css';
			link.href = '${info.rootTemplateURL}/main_lib/photoswipe/css/default-skin/default-skin.css';
			link.media = 'all';
			head.appendChild(link);
		}
		document.getElementById('photoswipe_container').classList.remove("hidden");
	}
</script>

<div id="photoswipe_container" class="pswp hidden" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="pswp__bg"></div>
	<div class="pswp__scroll-wrap">
		<div class="pswp__container">
			<div class="pswp__item"></div>
			<div class="pswp__item"></div>
			<div class="pswp__item"></div>
		</div>
		<div class="pswp__ui pswp__ui--hidden">
			<div class="pswp__top-bar">
				<div class="pswp__counter"></div>
				<button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
				<button class="pswp__button pswp__button--share" title="Share"></button>
				<button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
				<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
				<div class="pswp__preloader">
					<div class="pswp__preloader__icn">
						<div class="pswp__preloader__cut">
							<div class="pswp__preloader__donut"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
				<div class="pswp__share-tooltip"></div>
			</div>
			<button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>
			<button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>
			<div class="pswp__caption">
				<div class="pswp__caption__center"></div>
			</div>
		</div>
	</div>
</div>
</c:if>