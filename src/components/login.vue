<template>
  <div class="container loginform">
      <h6>登录</h6>
      <form action="">
          <div class="inputdiv">
             <input type="text" placeholder="请输入用户名" v-model.trim="user.username">
          </div>
          <div class="inputdiv">
              <input type="text" placeholder="请输入密码" v-model.trim="user.password">
          </div>
          <div>
              <button @click="login()">登录</button>
          </div>
          <div>
              
              <a href="#/regist">注册</a>
          </div>
      </form>
  </div>
</template>
<script>
import "../assets/css/login/login.scss";
export default {
  data() {
    return {
      user: {
        username: "15951954933",
        password: "666666"
      }
    };
  },

  created: function() {
    // this.checkLogin();    
    // this.checkLogin2();   
    //  this.cookies.delete('session');
  },
  methods: {
    checkLogin: function() {
      //检查是否存在session
      //cookie操作方法在源码里有或者参考网上的即可
      if (!this.getCookie("session")) {
        //如果没有登录状态则跳转到登录页
        ///this.$router.push("/login");
      } else {
        //否则跳转到登录后的页面
        this.$router.push("/");
      }
    },
    //登录逻辑
    login: function() {
      if (this.user.username != "" && this.user.password != "") {
        this.toLogin();
      }
    },
    toLogin: function() {
      //  this.$store.commit('changeLogin','100')     //登录后改变登录状态 isLogin = 100 ；
      sessionStorage.setItem('accessToken',1);
        this.$router.push("/");
      // this.axios.post('SFJ_M/wxJump/login1',{
      //   phone:this.user.username,
      //   password:this.user.password
      // }).then((response)=>{
      //   if(response.retCode===0){
      //     // this.$store.commit('changeLogin',100);
      //     this.$store.dispatch('loginAndOut',100);
      //   }else{
      //     alert("登录失败");
      //   }
      //   console.log(response);

      // }).catch((response)=>{
      //   console.log("====");
      //   console.log(response);
      // })
    }
  }
};
</script>

