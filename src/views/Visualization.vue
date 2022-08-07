<template>
  <div id="visualization">
    <div id="title-container">
      <h1>Harmful algal blooms</h1>
      <h2>in the Illinois River Basin</h2>
    </div>
    <WaterQuality />
  </div>
</template>

<script>

export default {
    name: 'Visualization',
    components: {
      WaterQuality: () => import( /* webpackPreload: true */ /*webpackChunkName: "section"*/ "./../components/WaterQuality")
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
