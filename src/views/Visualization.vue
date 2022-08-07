<template>
  <div id="visualization">
    <div id="title-container">
      <h1>Harmful algal blooms</h1>
      <h2>in the Illinois River Basin</h2>
    </div>
    <ilRiver id="il-river-svg" />
    <WaterQuality />
    <References />
  </div>
</template>

<script>
import ilRiver from '.././assets/images/il-river.svg';
export default {
    name: 'Visualization',
    components: {
      ilRiver,
      WaterQuality: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/WaterQuality"),
      References: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/References")
    },
    computed: {
    },
    mounted(){
    },
    methods:{
    }
} 
</script>

<style lang="scss">
#visualization {
  height: auto;
  margin: 2.5%;
  //width: 95%;
  //margin-top: 0;

}
</style>
