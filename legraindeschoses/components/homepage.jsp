<%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
		<a href="<jv:pageurl name='sommaires-2' />" style="border: 0 none;"> <picture
				class="home-picture">
			<source media="(max-width:800px)"
				srcset="${info.resourceRootURL}/static/images/home/bg_mobile.png" />
			<img class="home-pic" src="${info.resourceRootURL}/static/images/home/bg_desktop.png"
				alt="la revue sonore" /> </picture>
		</a> 

<style>

body #mic {
display: none;
}


#content {
position: relative;
}

.home-pic {
  max-width: 1920px;
  position: absolute;
  top: 0;    
  left: -9999px;
  right: -9999px;
  margin: auto;
  max-height: 75vh;
}

#main-nav {
	z-index: 100;
}
#main-nav #mainNavBar {
	z-index: 100;
}

h1 {
	display: none;
}

h3 {
	font-family: 'Arvo', serif;
}

body {
	background-color: #f2f4f1;
    overflow: hidden;
}

body .main-container {
	background-color: transparent;
}

body .main-container {
	padding-top: 0;
}

.home-wrapper {
	position: fixed;
	left: 0;
	width: 100%;
	bottom: 133px;
}

#home-subtitle-1 .home-title {
	position: fixed;
	left: 5%;
	bottom: 30%;
	font-size: 1em;
	color: #3f59aa;
	border-bottom: 1px #3f59aa solid;
}

@media (max-width : 800px) {
	.home-pic {
  		max-width: 800px;
    }

	#home-subtitle-1 .home-title {
		left: 30px;
		bottom: 135px;
	}

	#home-subtitle-1 {
		text-align: center;		
	}
}
</style>