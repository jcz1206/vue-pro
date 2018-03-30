import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

import newIndex from '@/components/index'
import regist from '@/components/regist'
import newLogin from '@/components/login'
import productlist from '@/components/product/productlist'
import my from '@/components/my/my'
import setting from '@/components/my/setting'

import store from '@/store/store.js'

Vue.use(Router)

//export default new Router({
  //routes: [
const routes=[
    {
      path: '/HelloWorld',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
        path: '/',
        name: 'newIndex',
        meta: {
            requireAuth: true, // 添加该字段，表示进入这个路由是需要登录的
        },
        component: newIndex
    },
    {
        path: '/regist',
        name: 'regist',
        component: regist
    },
    {
        path: '/newLogin',
        name: 'newLogin',
        component: newLogin
    },
    {
        path: '/productlist',
        name: 'productlist',
        component: productlist
    },
    {
        path: '/my',
        name: 'my',
        component: my
    },
    {
        path: '/setting',
        name: 'setting',
        component: setting
    }
  ]//,
  
//})
const router = new Router({
    routes // （缩写）相当于 routes: routes
  })

router.beforeEach((to,from,next) => {
    if(to.matched.some( m => m.meta.requireAuth)){
        // 对路由进行验证 
        if(store.state.isLogin===100) { // 已经登陆
            next()     // 正常跳转到你设置好的页面
        }else{
            // 未登录则跳转到登陆界面，query:{ Rurl: to.fullPath}表示把当前路由信息传递过去方便登录后跳转回来；
　　 　　　　next({path:'/newLogin',query:{ Rurl: to.fullPath} })
 　　　　　} 
　　　　}else{ 
　　　　　　next() 
　　} 
})

export default router;
