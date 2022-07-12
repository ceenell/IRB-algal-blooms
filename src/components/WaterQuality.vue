<template>
  <section>
    <div class="container">
      <svg id='bloom-bubbles-svg'/>
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
    bgColor: {
      type: String,
      default: "#0099CC"
    }
    },
    data() {
    return {
      publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
      d3: null,
      store,
      mobileView: isMobile, // test for mobile

      // dimensions
      w: store.state.windowWidth,
      h: store.state.windowHeight,
      margin: { top: 50, right: 50, bottom: 50, left: 50 },
      svg_chart: null,
      pal : { c1: '#9ED9C6', c2: '#64BFBA', c3: '#3CA8A7', c4: '#498CA6', c5: '#4B6996', c6: '#3B4B7E'},

      }
  },
  mounted(){      
      this.d3 = Object.assign(d3Base);
      
      svg_chart = this.d3.select('#bloom-bubbles-svg')
          .attr("viewBox", "0 0 " + this.w*0.95 + " " + (this.h*0.95))
          .append("g")
          .attr("id", "bubble-chart")

    },
    methods:{
      isMobile() {
              if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                  return true
              } else {
                  return false
              }
          },
       loadData() {
        const self = this;
        // read in data 
        let promises = [
        self.d3.csv(self.publicPath + "quant_peaks.csv",  this.d3.autotype), // used to draw legend shapes - color palette needs to be pulled out
        self.d3.csv("https://labs.waterdata.usgs.gov/visualizations/data/gw-conditions-year21.csv",  this.d3.autotype),
        self.d3.csv("https://labs.waterdata.usgs.gov/visualizations/data/gw-conditions-site-coords.csv",  this.d3.autotype), 
        self.d3.csv("https://labs.waterdata.usgs.gov/visualizations/data/gw-conditions-daily-proportions.csv",  this.d3.autotype),
        self.d3.csv("https://labs.waterdata.usgs.gov/visualizations/data/gw-conditions-time-labels.csv",  this.d3.autotype),
        ];
        Promise.all(promises).then(self.callback); // once it's loaded
      },
    }
}
</script>
<style scoped lang="scss">

</style>