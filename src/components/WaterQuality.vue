<template>
  <section>
    <div class="container" />
  </section>
</template>
<script>
import * as d3Base from 'd3';
export default {
  name: "WaterQuality",
    components: {
    },
    data() {
    return {
      publicPath: process.env.BASE_URL, // this is need for the data files in the public folder, this allows the application to find the files when on different deployment roots
      d3: null,

      // dimensions
      w: null,
      h: null,
      margin: { top: 50, right: 50, bottom: 50, left: 50 },
      svg_chart: null,

      }
  },
  mounted(){      
      this.d3 = Object.assign(d3Base);

    },
    methods:{
    }
}
</script>
<style scoped lang="scss">

</style>