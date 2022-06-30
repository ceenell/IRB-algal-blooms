<template>
  <div id="visualization">
    <h2>Harmful algal blooms</h2>
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
  margin: 2.5%;
  width: 95%;
}
</style>
