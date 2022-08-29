<template>
  <div id="visualization">
    <div id="title-container">
      <h1>Harmful algal blooms</h1>
      <h2>in the Illinois River Basin</h2>
    </div>
    <div class="title-container">
        <AlgalCommunity />
      </div>
    <div class="text-content">
      <p>Algal blooms are becoming increasingly common in the Illinois River Basin due to the imapcts of urban and agriculture on water quality. To better predict the timing, magnitude, and toxicity of harmful algal blooms (HABs) USGS is monitoring water quality and algal communities through large-scale sampling efforts and remote sensing.</p>
    </div>
    <!--     sticks to top of page as scrolling through different sections -->
  <!--   <div id="nav-menu"> -->
  <!--              <h4 id="nav-text">
        continuous water quality | algae and toxins | remote sensing
      </h4> -->
         <ilRiver id="il-river-svg" />
<!--     </div> -->
  
    <div
      id="cont-water-quality"
      class="content"
    >
      <div class="title-container">
        <h3>Continuous water quality</h3>
      </div>
      <WaterQuality />
    </div>
    <div
      id="algae-toxins"
      class="content"
    >
    </div>
    <div
      id="remote-sensing"
      class="content"
    >
      <div class="title-container">
        <h3>Remote Sensing</h3>
      </div>
    <RemoteSensing />
    <ImgCarousel id="carousel" />
        </div>
        <div
      id="remote-sensing"
      class="content"
    >
    <References />
   </div>
  </div>
</template>

<script>
import ilRiver from '.././assets/images/IllinoisRiver_stations_header.svg';
export default {
    name: 'Visualization',
    components: {
      ilRiver,
      WaterQuality: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/WaterQuality"),
      AlgalCommunity: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/AlgaeCommunity"),
      RemoteSensing: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/RemoteSensing"),
      ImgCarousel: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/ImgCarousel"),
      References: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/References")
    },
    computed: {
    },
    /* mounted(){
      // sticky header
      window.onscroll = function() {myFunction()};
      var header = document.getElementById("nav-menu"); // Get the header
      var sticky = header.offsetTop;  // Get the offset position of the navbar
      // Add the sticky class to the header when you reach its scroll position. Remove "sticky" when you leave the scroll position
      function myFunction() {
        if (window.pageYOffset > sticky) {
          header.classList.add("sticky");
        } else {
          header.classList.remove("sticky");
        }
      }


    }, */
    methods:{
    }
} 
</script>

<style lang="scss">
#visualization {
  height: auto;
  margin: 5%;
  //width: 95%;
  //margin-top: 0;
//background-color:#102f36
}
#nav-menu {
  //background-color: rgb(185, 227, 255);
  text-align: center;
  padding-top: 20px;
}
#nav-text {
  margin-bottom: 30px;
}
#carousel {
  max-width: 1200px;
  margin:auto;
}
.sticky {
  position: fixed;
  top: 0;
  left:0;
  width: 100vw;
}
/* Page content */

.content, #title-container {
  padding: 16px;
  max-width: 1000px;
  margin: auto;
  //margin-top: 5rem;
}
.content{
  margin-bottom: 5rem;
}
/* Add some top padding to the page content to prevent sudden quick movement (as the header gets a new position at the top of the page (position:fixed and top:0) */
.sticky + .content {
  padding-top: 240px;
}
#il-river-svg {
  //margin-top: 20px;
  width: 100vw;
  height: auto;
  //max-height: 60vh;
  margin: auto;
  margin-left: -5vw;
  position: relative;
  top: -150px; // should be a little less than the height of the USGS header and title calc()
}

</style>
