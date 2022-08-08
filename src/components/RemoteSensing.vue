<template>
  <section id="algae-community">
    <div class="flex-container" />
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
        // read in data here
      },
      callback(data) {
        const self = this;
        // assign data

      }
    }
}
</script>
<style scoped lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@200;300;400;500;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Edu+SA+Beginner:wght@400;500;600;700&display=swap');
$scriptFont: 'Edu SA Beginner', cursive;
$SourceSans: 'Source Sans Pro', sans-serif;
button {
    appearance: auto;
    text-rendering: auto;
    letter-spacing: normal;
    word-spacing: normal;
    line-height: normal;
    align-items: center;
    box-sizing: border-box;
    padding: 1rem 4px;
    margin: 0rem 2.5rem;;
}
.usa-button, .usa-button--inverse {
  color: #bff1e2;
  border: white;
  justify-content: space-evenly;
  width: 100px;
  height: auto;
  border: 2px solid #bff1e2;
  background: #0b3852;
  color: #bff1e2;
  border-radius: 0.35rem;
  cursor: pointer;
  font-weight: 500;
  font-size: 2.25rem;
  font-family: $scriptFont;
  padding: 0.5rem 0.5rem;
  text-align: center;
  text-decoration: none;
  overflow: visible;
  @media screen and (max-width: 600px) {
      font-size: 2em;
  }  
}
button:hover {
    background: #bff1e2;
    color: #0b3852;
}
button:active {
  background-color: #0b3852;
  color: #bff1e2;
  transform: translateY(3px) translateX(2px) scale(0.9, 0.9);
}
</style>