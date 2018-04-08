// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'


import axios from 'axios'
import VueAxios from 'vue-axios'
import Qs from 'qs'

import '@/assets/css/base/reset.css'
// import '@/assets/css/normalize.css'
import '@/assets/bootstrap/css/bootstrap.min.css'
//将css 放在app前面，css的加载顺序就不会有问题了
import '@/assets/iconfonts/iconfont.css'

import 'lib-flexible/flexible'
import App from './App'
import store from './store/store'
import router from './router'


Vue.config.productionTip = false //关闭生产模式下给出的提示


// #创建一个axios实例
var axios_instance = axios.create({
    // #config里面有这个transformRquest，这个选项会在发送参数前进行处理。
    // #这时候我们通过Qs.stringify转换为表单查询参数
    transformRequest: [function(data) {
            data = Qs.stringify(data);
            return data;
        }] //,
        //       // `transformResponse` 在传递给 then/catch 前，允许修改响应数据
        //     transformResponse: [function (data) {
        //       // 对 data 进行任意转换处理

    //       return data;
    //     }],
    //     timeout: 1000,
    // // #设置Content-Type
    //     headers:{'Content-Type':'application/x-www-form-urlencoded'}
})

//axios配置
axios_instance.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

//post序列化
axios_instance.interceptors.request.use((config) => {
        config.headers['Content-Type'] = 'application/x-www-form-urlencoded';
        return config;
    }, (error) => {
        return Promise.reject(error);
    })
    //返回状态判断
axios_instance.interceptors.response.use((res) => {
    if (res.status != 200) {
        alert("报错了");
        return Promise.reject(res);
    }
    return res.data;
}, (error) => {
    return Promise.reject(error);
})

//封装 axios的get post方法
// Vue.prototype.axi={
//   post:function(url,params){
//     let parameters=Qs.stringify(params);
//     return new Promise((resolve,reject)=>{
//       axios.post()
//     })
//   },
//   get:function(){

//   }
// }
Vue.use(VueAxios, axios_instance)
    // Vue.use(VueAxios,axios);


/* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    store,
    components: { App },
    template: '<App/>'
})