<template>
  <section id="algae-community">
    <div class="flex-container">
      <!-- <div class="text-content">
        <p>During an algal bloom, algal community composition changes and may become dominated by certain taxa.</p>
      </div> -->
    </div>
    <div class="flex-container">
      <img
        id="algae-biovolume"
        src="@/assets/images/biovolume_perc_time.png"
      >
      <div class="text-content">
        <p>Relative biovolume of Chrysophyta, Chlorophyta, and Cyanobacteria at Starved Rock in 2021.</p>
        <h4>What makes an algal bloom harmful?</h4>
        <p>Vestibulum egestas, velit et hendrerit ornare, justo felis porta nulla, non volutpat quam nulla non felis. Vestibulum luctus massa egestas nulla laoreet, non semper elit sodales. Duis facilisis mauris ut malesuada aliquam.</p>
      </div>
    </div>
  </section>
</template>
<script>
import * as d3Base from 'd3';
import { store } from '../store/store.js'
export default {
  name: "AlgaeCommunity",
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
        genus_total: null,
        genus_sample_total: null,

        // dimensions
        w: store.state.windowWidth,
        h: store.state.windowHeight,
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
          //self.d3.csv(self.publicPath + "genus_total.csv",  this.d3.autotype),
          //self.d3.csv(self.publicPath + "genus_sample_total.csv",  this.d3.autotype)
        ];
        Promise.all(promises).then(self.callback); // once it's loaded
        
      },
      callback(data) {
        const self = this;
        // assign data

      }
    }
}
</script>
<style scoped lang="scss">


img {
    height: auto;
    max-height: 50vh;
    width: 90vw;
    max-width: 1400px;
    margin: auto;
  }
</style>