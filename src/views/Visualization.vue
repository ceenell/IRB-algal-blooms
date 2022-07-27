<template>
  <div id="visualization">
    <div id="title-container">
      <h2>Harmful algal blooms</h2>
      <h3>in the Illinois River Basin</h3>
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
  height: calc(100vh);
  margin: 2.5%;
  //width: 95%;
  //margin-top: 0;

}
</style>
