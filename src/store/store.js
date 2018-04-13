import Vue from 'vue'

import Vuex from 'vuex'
Vue.use(Vuex);
const store = new Vuex.Store({
    state: {
        // isLogin: 0, //初始时候给一个  isLogin=0  表示用户未登录
        // user: {}, //用戶的信息
        cart: []
    },
    mutations: {
        // changeLogin(state, data) {
        //     state.isLogin = data;
        // },
        cartadd0 (state,{items}) {
          state.cart.push(items);
        }
    },
    actions: {
        // loginAndOut: function(state, data) {
        //     state.commit('changeLogin', data)
        // }
        cartadd({commit,state},prod){
            commit("cartadd0",{items:prod});
        }
    }
})
export default store;
