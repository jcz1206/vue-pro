<template>
    <header>
        <div class="header-wrap" >
            <i class="icon iconfont icon-xiangzuojiantou" @click="backurl"></i>{{title}}</div>
    </header>
</template>
<script>
export default {
  name:"backheader",
  props:["title"],
  methods:{
      backurl:function(){
          this.$router.go(-1);
      }
  }
}
</script>
<style scoped>
    .header-wrap{
        text-align:center; 
        color:#fff;
    }

    .icon-xiangzuojiantou{
        float:left; 
        width: 20px;
    }

</style>


