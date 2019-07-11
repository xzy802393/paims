package com.cz.yingpu.system.pc;
import com.cz.yingpu.system.entity.WorldCupInexistenceU;

import java.util.Random;

/**
 * 随机生成中文姓名，性别，Email，手机号，住址
 * @author X-rapido
 */
public class pohneNumber {

    public static int getNum(int start,int end) {
        return (int)(Math.random()*(end-start+1)+start);
    }



    /**
     * 返回手机号码
     */
    private static String[] telFirst="134,135,136,137,138,139,150,151,152,157,158,159,130,131,132,155,156,133,153".split(",");
    private static String getTel() {
        int index=getNum(0,telFirst.length-1);
        String first=telFirst[index];
      //  String second=String.valueOf(getNum(1,888)+10000).substring(1);
        String third=String.valueOf(getNum(1,9100)+10000).substring(1);
        return first+"****"+third;
    }


    public static int getM() {
        Random rand = new Random();
        int a=rand.nextInt(9) + 1;
        return a;
    }

    /**
     * 数据封装
     * @return
     */
    public static WorldCupInexistenceU getAddress(double money) {

        WorldCupInexistenceU  user =new WorldCupInexistenceU();
        user.setPhone(getTel());
        user.setGetMoney(money);
        return user;

    }

//    public static void main(String[] args) {
//        for (int i = 0; i < 100; i++) {
//         getAddress();
//        System.out.println(getAddress());
//        }
//    }
}