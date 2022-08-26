<template>
  <div class="maxWidth carouselContainer">
    <carousel
      class="image-slider"
      :autoplay="true"
      :autoplay-hover-pause="true"
      :per-page="3"
    >
      <slide class="slide">
        <div class="slider-image-container">
          <picture>
           <!--  <source
              srcset="@/assets/images/person1.webp"
              type="image/webp"
            > -->
            <source
              srcset="https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/thumbnails/image/L8_9-26-2017_432.jpg"
              type="image/jpg"
            >
            <img 
              id="field1"
              v-img="{
                thumbnails: true,
                group: 'group', 
                title: ''
              }"
              class="sliderImage"
              src="https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/thumbnails/image/L8_9-26-2017_432.jpg"
              alt=""
              loading="lazy"
            >
          </picture>
        </div>
      </slide>

      <slide class="slide">
        <div class="slider-image-container">
          <picture>
           <!--  <source
              srcset="@/assets/images/drone1.webp"
              type="image/webp"
            > -->
            <source
              srcset="https://landsat.gsfc.nasa.gov/wp-content/uploads/2017/05/20170508-nu2.png"
              type="image/png"
            >
            <img 
              id="field2"
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="https://landsat.gsfc.nasa.gov/wp-content/uploads/2017/05/20170508-nu2.png"
              alt=""
              loading="lazy"
            >
          </picture>
        </div>
      </slide>

      <slide class="slide">
        <div class="slider-image-container">
          <picture>
            <!-- <source
              srcset="@/assets/images/station4.webp"
              type="image/webp"
            > -->
            <source
              srcset="https://landsat.gsfc.nasa.gov/wp-content/uploads/2017/05/20170508-nu1.png"
              type="image/png"
            >
            <img 
              id="field4"
              v-img="{
                group: 'group',
                thumbnails: true
              }"
              class="sliderImage"
              src="https://landsat.gsfc.nasa.gov/wp-content/uploads/2017/05/20170508-nu1.png"
              alt=""
              loading="lazy"
            >
          </picture>
        </div>
      </slide>
     
    </carousel>
  </div>
</template>

<script>
    import { Carousel, Slide } from 'vue-carousel';
    export default {
        name: 'ImgCarousel',
        components:{
            Carousel,
            Slide
        }
    }
</script>

<style scoped lang="scss">
  .image-slider {
    *:focus{
      outline: none;
    }
  }
  .slide {
    margin: 0;
    padding: 0;
    select:focus{
      outline: none;
    }
  }
  .slider-image-container {
    padding: 10px;
    display: block;
    height: 400px;
    width: auto;
    object-fit: contain;
    img {
      height: 400px; 
      width: auto;
    }
  }
</style>