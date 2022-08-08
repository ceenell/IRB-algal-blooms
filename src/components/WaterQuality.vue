<template>
  <section id="water-quality">
    <div class="flex-container">
      <!-- two column layout -->
      <div class="flex-left">
        <div class="text-content">
          <h4>Dissolved Oxygen (DO)</h4>
          <p>Vestibulum egestas, velit et hendrerit ornare, justo felis porta nulla, non volutpat quam nulla non felis. Vestibulum luctus massa egestas nulla laoreet, non semper elit sodales. Duis facilisis mauris ut malesuada aliquam.</p>
        </div>
        <div class="text-content">
          <h4>Algal Fluorescence (fChl)</h4>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum lacinia ut tellus vel bibendum. Etiam lacinia tortor erat, eget sagittis nisi pulvinar consectetur. Vestibulum egestas, velit et hendrerit ornare, justo felis porta nulla, non volutpat quam nulla non felis.</p>
        </div>
      </div>
      <div class="flex-right">
        <img
          src="@/assets/images/do-and-fchl.png"
        >
      </div>
    </div>
  </section>
</template>
<script>
import * as d3Base from 'd3';
import { store } from '.././store/store.js'

export default {
  name: "WaterQuality",
    components: {
    },
    props: {
    },
    data() {
      return {
        publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
        d3: null,
        store,

        // dimensions
        margin: { top: 50, right: 50, bottom: 50, left: 50 },
        svg_chart: null,
        pal : { c1: '#9ED9C6', c2: '#64BFBA', c3: '#3CA8A7', c4: '#498CA6', c5: '#4B6996', c6: '#3B4B7E', c7: '#14C9CB', c8: '#08B3E5', c9: '#0FBED8' },

        }
  },
  mounted(){      
      this.d3 = Object.assign(d3Base);
      this.loadData()
  
    },
    methods:{
       loadData() {
        const self = this;
        // read in data 
        let promises = [
        ];
        Promise.all(promises).then(self.callback); // once it's loaded
        
      },
      callback(data) {
        const self = this;
        

      }
    }
}
</script>
<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;300;400;500;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Edu+SA+Beginner:wght@400;500;600;700&display=swap');
$scriptFont: 'Edu SA Beginner', cursive;
$SourceSans: 'Source Sans Pro', sans-serif;

.flex-left {
    width: 50%;
    max-width: 500px;
    //height: 100vh;
    padding: 5%;
}

.flex-right {
    width: 50%;
}
img {
    max-height: 70vh;
    margin: auto;
  }
</style>