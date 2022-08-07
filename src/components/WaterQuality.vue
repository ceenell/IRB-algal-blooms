<template>
  <section id="water-quality">
    <div class="image-container" >
      <img
      src="@/assets/images/do-and-fchl.png" />
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
       loadData() {
        const self = this;
        // read in data 
        let promises = [
          self.d3.csv(self.publicPath + "genus_total.csv",  this.d3.autotype),
          self.d3.csv(self.publicPath + "genus_sample_total.csv",  this.d3.autotype)
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

.image-container {
  margin: 2.5%;
  width: auto;
  max-height: 100vh;
  img {
    max-height: 50vh;
  }

}
</style>