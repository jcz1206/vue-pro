<template>
  <div>
      <a href="javascript:;" @click="loginOut()">退出</a>
  </div>
</template>
<script>
export default {
  methods:{
      loginOut:function(){
          this.$store.commit('changeLogin','0');  
        //   this.axi.post("/loginOut",{}).then(
        //       respose=>{
        //           if(respose.retCode==0){
        //               alert(respose.retMsg);
        //           }
        //       },
        //       respose=>{
        //           alert("Error");
        //       }
        //   );
      }
  }
}
</script>

