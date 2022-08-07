<template>
  <section id="algae-community">
    <div class="container">
      <svg id="bloom-bubbles-svg" />
      <button
        class="usa-button usa-button--inverse"
        @click="backStep()"
      >
        back
      </button>
      <button
        class="usa-button usa-button--inverse"
        @click="nextStep()"
      >
        next
      </button>
    </div>
  </section>
</template>
<script>
import * as d3Base from 'd3';
import { store } from '../store/store.js'
import { isMobile } from 'mobile-device-detect';

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
        genus_total: null,
        genus_sample_total: null,
        step: 1,
        nodes: null,
        nodez: null,

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
      
      this.svg_chart = this.d3.select('#bloom-bubbles-svg')
          .attr("viewBox", "0 0 " + (this.w*0.95) + " " + (this.h*0.75))
          .attr("style", "max-width: 100%; max-height: 100%; height: auto;")
          .append("g")
          .attr("id", "bubble-chart")

      this.step = 1;

    },
    methods:{
      nextStep() {
        this.step ++;
        console.log(this.step)
        this.toSamples()
      },
      backStep() {
        this.step --;
        console.log(this.step)
      },
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
          self.d3.csv(self.publicPath + "genus_total.csv",  this.d3.autotype),
          self.d3.csv(self.publicPath + "genus_sample_total.csv",  this.d3.autotype)
        ];
        Promise.all(promises).then(self.callback); // once it's loaded
        
      },
      callback(data) {
        const self = this;
        // assign data
        // builds legend, has row for each category
        this.genus_total = data[0]; 
        this.genus_sample_total = data[1]; 
        console.log(this.genus_total)
        this.bubbleAll(this.svg_chart, this.genus_total)
        //this.toSamples(this.svg_chart, this.genus_sample_total)
      },
      bubbleAll(svg, genus_data){
          const self = this
          var v = this
          // divisions names
          let algae_divisions = [...new Set(genus_data.map(function(d) { return d.division }))];

          var color = this.d3.scaleOrdinal()
            .domain(algae_divisions)
            .range([this.pal.c1, this.pal.c2, this.pal.c3, this.pal.c4, this.pal.c5, this.pal.c6, this.pal.c7, this.pal.c8, this.pal.c9]);

          var size = this.d3.scaleLinear()
            .domain([0, 100])
            .range([10,100])  

        this.nodes = svg.selectAll("circle")
          .data(this.genus_total, function(d) { return d.taxa_name })
          .enter()
          .append("circle")
            .attr("class", "bubble")
            .attr("r", function(d){ return (size(d.cells_percent)) })
            .attr("cx", this.w / 2)
            .attr("cy", this.h*0.4)
           .style("fill", function(d){ return color(d.division)})
            .style("fill-opacity", 0.8)
            .attr("stroke", "white")
            .style("stroke-width", 1.5) 
 
        var simulation = this.d3.forceSimulation()
            .force("charge", this.d3.forceManyBody().strength(function(d){ return d.cells_percent*0.001 }))
            //.force("center", this.d3.forceCenter().x(this.w / 2).y(this.h*0.3)) // to the center of the svg
            .force("forceX", this.d3.forceX().strength(.1).x(this.w * .5))
            .force("forceY", this.d3.forceY().strength(.05).y(this.h * .3))
            .force("collide", this.d3.forceCollide().strength(.2).radius(function(d){ return (size(d.cells_percent)+3) }).iterations(2)) // Force that avoids circle overlapping
        //simulation.stop();
        simulation
            .nodes(this.genus_total)
            .on("tick", function(d){
              self.nodes
                  .attr("cx", function(d){ return d.x; })
                  .attr("cy", function(d){ return d.y; })
            });

      },
      toSamples(svg, genus_sample){
        const self = this
       var groups = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550];
       let algae_divisions = [...new Set(genus_sample.map(function(d) { return d.division }))];
       let sample_ids = [...new Set(genus_sample.map(function(d) { return d.sample_id }))];

          var color = this.d3.scaleOrdinal()
            .domain(algae_divisions)
            .range([this.pal.c1, this.pal.c2, this.pal.c3, this.pal.c4, this.pal.c5, this.pal.c6, this.pal.c7, this.pal.c8, this.pal.c9]);

          var size = this.d3.scaleLinear()
            .domain([0, 100])
            .range([10,100])  
        
         this.nodez = svg.selectAll("circle")
          .data(genus_sample, function(d) { return d.taxa_name })
          .enter()
          .append("circle")
            .attr("class", "bubble")
            .attr("r", function(d){ return (size(d.cells_percent)) })
            .attr("cx", this.w / 2)
            .attr("cy", this.h*0.4)
           .style("fill", function(d){ return color(d.division)})
            .style("fill-opacity", 0.8)
            .attr("stroke", "white")
            .style("stroke-width", 1.5) 
        
       var simulation = this.d3.forceSimulation()
          .force('charge', this.d3.forceManyBody().strength(0.15))
          .force('x', this.d3.forceX().x(function(d,i) {
            return groups[i];
          }))
          .force("forceY", this.d3.forceY().strength(.05).y(this.h * .3))
          .force('collision', this.d3.forceCollide().radius(function(d){ return (size(d.cells_percent)+3) }).iterations(2))

          simulation
            .nodes(genus_sample)
            .on("tick", function(d){
              self.nodez
                  .attr("cx", function(d){ return d.x; })
                  .attr("cy", function(d){ return d.y; })
            });
          

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