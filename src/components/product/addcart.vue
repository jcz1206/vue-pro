<template>

</template>
<!--
<style  lang="scss" scoped rel="stylesheet/scss">
//这样引入的话，css内图片的路径要写这个component的相对路径
@import '../../assets/css/product/category.scss';
</style>
-->
<script>
import '../../assets/css/product/category.scss';
//这样引入的话，css内图片的路径要写css的相对路径即可
export default {
  name:"category",
  props:["cateid"],
  data(){
      return {
          data:{
              category:[{
                id:"c001",
                catename:"水",
                child:[
                    {
                id:"001001",
                catename:"水1"  
                    },
                    {
                id:"001001",
                catename:"水2"  
                    }
                ]
              },
              {
                id:"c002",
                catename:"电" 
              },
              {
                id:"c003",
                catename:"木" 
              },
              {
                id:"c004",
                catename:"土" 
              },
              {
                id:"c005",
                catename:"板材" 
              },
              {
                id:"c006",
                catename:"五金" 
              },
              {
                id:"c007",
                catename:"油漆" 
              }]
            }
      }
  },
  methods:{
        onClickMe: function(id){
          $(event.currentTarget).addClass("on").siblings("a").removeClass("on");
          this.$parent.cateid=id;
          this.$parent.getProductlist(id);
          // console.log(this.$parent);  //访问根组件  
          // console.log(this.$parent.cateid);  //访问根组件的cateid属性  
          // this.$emit('child-say',id);
        }
  }
}
</script>
