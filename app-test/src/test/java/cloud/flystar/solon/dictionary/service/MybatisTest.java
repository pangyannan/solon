package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.core.util.SqlMapper;
import cn.hutool.core.io.IoUtil;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.RepeatedTest;

import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author: pangyannan
 */
public class MybatisTest {

    @RepeatedTest(1)
    @Order(10)
    void listAll() {
//        InputStream in = Resources.getResourceAsStream("mybatis-config.xml");//读取mybatis的主配置文件，构建输入流
        ByteArrayInputStream in = IoUtil.toUtf8Stream(config2());
        SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
        SqlSessionFactory sessionFactory = builder.build(in);


        for (int i = 0; i < 1000; i++) {


            SqlSession sqlSession = sessionFactory.openSession();

            SqlMapper sqlMapper = new SqlMapper(sqlSession);
            String sql = getSql();
            System.out.println("数据库语句：" + sql);
            List<Map<String, Object>> maps = sqlMapper.selectList(sql);
            System.out.println(JsonUtil.json(maps));


            String mapper = getMapper();
            System.out.println("数据库语句mapper：" + mapper);

            Map<String,String> params = new HashMap<>();
            params.put("country_code2","AF");
            List<Map<String, Object>> mapperResult = sqlMapper.selectList(mapper,params);

            System.out.println(JsonUtil.json(mapperResult));



            sqlSession.commit();
            sqlSession.close();
        }

    }




    public static String config(){
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n" +
                "<!DOCTYPE configuration\n" +
                "        PUBLIC \"-//mybatis.org//DTD Config 3.0//EN\"\n" +
                "        \"http://mybatis.org/dtd/mybatis-3-config.dtd\">\n" +
                "<configuration>\n" +
                "    <environments default=\"mysql\">\n" +
                "        <environment id=\"mysql\">\n" +
                "            <transactionManager type=\"JDBC\"/>\n" +
                "            <dataSource type=\"POOLED\"> \n" +
                "                <property name=\"driver\" value=\"com.mysql.cj.jdbc.Driver\"/>\n" +
                "                <property name=\"url\" value=\"jdbc:mysql://localhost:3306/solon\"/>\n" +
                "                <property name=\"username\" value=\"root\"/>\n" +
                "                <property name=\"password\" value=\"123456\"/>\n" +

                "                <property name=\"poolMaximumIdleConnections\" value=\"10\"/>\n" +
                "                <property name=\"poolMaximumActiveConnections\" value=\"20\"/>\n" +
                "                <property name=\"poolPingQuery\" value=\"SELECT 1 FROM DUAL\" />  \n" +
                "                <property name=\"poolPingEnabled\" value=\"true\" />  \n" +

                "            </dataSource>\n" +
                "        </environment>\n" +
                "    </environments>\n" +
                "</configuration>"
                ;
    }



    public static String config2(){
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n" +
                "<!DOCTYPE configuration\n" +
                "        PUBLIC \"-//mybatis.org//DTD Config 3.0//EN\"\n" +
                "        \"http://mybatis.org/dtd/mybatis-3-config.dtd\">\n" +
                "<configuration>\n" +
                "    <environments default=\"mysql\">\n" +
                "        <environment id=\"mysql\">\n" +
                "            <transactionManager type=\"JDBC\"/>\n" +
                "            <dataSource type=\"cloud.flystar.solon.framework.util.MyPooledDataSourceFactory\"> \n" +
                "                <property name=\"driverClassName\" value=\"com.mysql.cj.jdbc.Driver\"/>\n" +
                "                <property name=\"jdbcUrl\" value=\"jdbc:mysql://localhost:3306/solon\"/>\n" +
                "                <property name=\"username\" value=\"root\"/>\n" +
                "                <property name=\"password\" value=\"123456\"/>\n" +

                "                <property name=\"maxPoolSize\" value=\"20\"/>\n" +
                "                <property name=\"minIdle\" value=\"5\"/>\n" +
                "                <property name=\"connectionTimeout\" value=\"30000\"/>\n" +
                "            </dataSource>\n" +
                "        </environment>\n" +
                "    </environments>\n" +
                "</configuration>"
                ;
    }

    public String  getSql(){
        return "select * from  mdm_gbt2259";
    }

    public String getMapper(){

        return "<script> " +
                    "select * from mdm_gbt2259 " +
                    "where 1=1" +
                    "<if test=\"country_code2 != null\"> and country_code2 = #{country_code2}</if>" +
                "</script>";
    }
}
