use easybuy

--用户表
select * from easybuy_user;
--收货地址
select * from easybuy_user_address;
--商品列表
select * from easybuy_product_category;
--商品
select * from easybuy_product;
--订单表
select * from easybuy_order;
--订单详情表
select * from easybuy_order_detail;
--新闻资讯表
select * from easybuy_news;


--登录
select * from easybuy_user where loginName='admin' and `password` ='e10adc3949ba59abbe56e057f20f883e';
--注册
insert into easybuy_user(loginName,userName,`password`,sex,identityCode,email,mobile)
values('zs','张三','123456',1,'132288189987846589','10447322658@qq.com','18810224174')

--查询页面左侧导航
select * from easybuy_product_category;

-- 根据一级获取二级三级
select e2.name,e3.name
from easybuy_product_category e1,
easybuy_product_category e2,
easybuy_product_category e3
where e3.parentId=e2.id
and e2.parentId=e1.id
and e1.name='化妆品'

--一级
select e1.name
from easybuy_product_category e1

--分页查询新闻
select * from easybuy_news 
order by createTime desc 
limit 0,5;

--商品列表
select * from easybuy_product_category;
--商品
select * from easybuy_product;

--根据1级查二级
select e2.name,e2.id,e1.id
from easybuy_product_category e1,
easybuy_product_category e2
where e2.parentId=e1.id
and e1.name='化妆品'

--根据一级二级菜单id 查3级菜单前6条内容
select * from easybuy_product
where categoryLevel2Id=654
and categoryLevel1Id=548
limit 0,6

--点击商品进入商品详情
select * from easybuy_product where id=734;

--查询当前用户id
select * from easybuy_user where id=10; 

--插入订单信息
insert into easybuy_order(userId,loginName,userAddress,createTime,cost,serialNumber)
values(10,'cgn','北京市花园路小区',now(),5200,'20152255556');



--用户表
select * from easybuy_user;
--收货地址
select * from easybuy_user_address;
--订单表
select * from easybuy_order;
--订单详情表
select * from easybuy_order_detail;