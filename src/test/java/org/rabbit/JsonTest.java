package org.rabbit;

import org.junit.Test;
import org.rabbit.vo.User;

public class JsonTest {

    @Test
    public void test1() {
        User user = new User(1001, "张三", "123", "1234657909", "zs@gmail.com", "吉林省长春市", 1);
    }

}
