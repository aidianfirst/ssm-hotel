<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/css/layui.css"
          media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%-- 搜索条件 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">入住人</label>
                            <div class="layui-input-inline">
                                <input type="text" name="reservationName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">身份证号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="idCard" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">手机号码</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">房间类型</label>
                            <div class="layui-input-inline">
                                <select name="roomTypeId" autocomplete="off" class="layui-input s_roomTypeId">
                                    <option value="">全部</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">入住状态</label>
                            <div class="layui-input-inline">
                                <select name="status" autocomplete="off" class="layui-input">
                                    <option value="">全部</option>
                                    <option value="1">入住中</option>
                                    <option value="2">已离店</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">入住日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="arriveDate" id="startDate" autocomplete="off" class="layui-input" placeholder="请选择入住日期" readonly>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">离店日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="leaveDate" id="endDate" autocomplete="off" class="layui-input" placeholder="请选择离店日期" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="text-align: center">
                            <button type="submit" class="layui-btn"  lay-submit lay-filter="data-search-btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
                            <button type="reset" class="layui-btn layui-btn-warm"><i class="layui-icon layui-icon-refresh-1"></i>重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <%-- 表格工具栏 --%>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="checkIn"><i
                        class="layui-icon layui-icon-edit"></i>登记入住
                </button>
            </div>
        </script>

        <%-- 数据表格 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <%-- 行工具栏 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="checkout">
                <i class="layui-icon layui-icon-delete"></i>退房</a>
        </script>

        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">预订编号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="ordersId" lay-verify="required" autocomplete="off" readonly placeholder="请选择预订订单" class="layui-input">
                        </div>
                        <div class="layui-form-mid" style="position:relative;bottom:5px;">
                            <button type="button" class="layui-btn layui-btn-sm" id="openOrdersWindow"><i class="layui-icon layui-icon-add-circle-fine"></i>选择订单</button>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">所属房型</label>
                        <div class="layui-input-inline">
                            <input type="hidden" name="roomTypeId">
                            <input type="text" name="roomTypeName" placeholder="请选择房型" lay-verify="required" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">房间编号</label>
                        <div class="layui-input-inline">
                            <input type="hidden" name="roomId">
                            <input type="text" name="roomNum" placeholder="请输入房间号码" lay-verify="required" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">入住人</label>
                        <div class="layui-input-inline">
                            <input type="text" name="customerName" placeholder="请输入入住人姓名" lay-verify="required" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline">
                            <input type="text" name="phone" placeholder="请输入手机号码"  lay-verify="required" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">入住价格</label>
                        <div class="layui-input-inline">
                            <input type="text" name="payPrice" placeholder="请输入入住价格" lay-verify="required" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">入住状态</label>
                        <div class="layui-input-inline">
                            <input type="text" value="已入住" autocomplete="off" readonly class="layui-input">
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">入住日期</label>
                        <div class="layui-input-inline">
                            <input type="text" name="arriveDate" placeholder="请选择入住日期" readonly autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">离店日期</label>
                        <div class="layui-input-inline">
                            <input type="text" name="leaveDate" placeholder="请选择离店日期" readonly autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">身份证号</label>
                    <div class="layui-input-block">
                        <input type="text" name="idCard"placeholder="请输入身份证号码" lay-verify="required" autocomplete="off" readonly class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-block">
                        <textarea class="layui-textarea" name="remark"></textarea>
                    </div>
                </div>
                <div class="layui-form-item layui-row layui-col-xs12">
                    <div class="layui-input-block" style="text-align: center;">
                        <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span
                                class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-warm"><span
                                class="layui-icon layui-icon-refresh-1"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 选择预定订单窗口 -->
        <div style="display: none;" id="selectOrdersWindow">
            <%-- 数据表格 --%>
            <table class="layui-hide" id="ordersTableId" lay-filter="ordersTableFilter"></table>
        </div>

    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>


    layui.use(['form', 'table', 'laydate', 'jquery', 'layer'], function () {
        var $ = layui.jquery,
            form = layui.form,
            laydate = layui.laydate,
            layer = layui.layer,
            table = layui.table;

        //渲染日期组件
        laydate.render({
            elem: '#startDate', //指定元素
            type: 'datetime'
        });
        laydate.render({
            elem: '#endDate', //指定元素
            type: 'datetime'
        });

        /**
         * 查询房型 ——下拉列表
         */
        $.get("/admin/roomType/findAll",function (result) {
            var html = "";
            for(var i = 0;i < result.length;i++){
                html += "<option value='"+result[i].id+"'>"+result[i].typeName+"</option>"
            }
            //数据添加到下拉列表
            $("[name='roomTypeId']").append(html);
            //渲染下拉列表
            form.render("select");

        },"json");


        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/checkin/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 100, title: '入住编号', align: "center"},
                {field: 'roomType', width: 100, title: '入住房型', align: "center",templet:function (s) {
                        return s.roomType.typeName;
                    }},
                {field: 'room', width: 80, title: '房间号', align: "center",templet:function (s) {
                        return s.room.roomNum;
                    }},
                {field: 'customerName', width: 100, title: '入住人', align: "center"},
                {field: 'idCard', minWidth: 120, title: '身份证号', align: "center"},
                {field: 'phone', width: 150, title: '手机号', align: "center"},
                {field: 'status', width: 100, title: '状态', align: "center",templet:function (s){
                    return s.status==3 ? "入住中" : "已退房";
                    }},
                {field: 'payPrice', width: 120, title: '支付金额', align: "center"},
                {field: 'arriveDate', width: 170, title: '入住日期', align: "center"},
                {field: 'leaveDate', width: 170, title: '离店日期', align: "center"},
                {title: '操作', width: 150, toolbar: '#currentTableBar', align: "center",fixed:"right"}
            ]],
            page: true,
            done: function (res, curr, count) {
                //判断当前页码是否是大于1并且当前页的数据量为0
                if (curr > 1 && res.data.length == 0) {
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    });
                }
            }
        });


        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });

        table.on("toolbar(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "checkIn":
                    openCheckInWindow(obj.data);
                    break;
            }
        });

        table.on("tool(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "checkout":
                    checkOut(obj.data);
                    break;
            }
        });


        var url,mainIndex;

        //登记入住
        function openCheckInWindow(data) {
            mainIndex = layer.open({
                type: 1,
                title: "登记入住",
                area: ["800px","500px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //清空表单数据，不然每次打开都会有上次的数据
                    $("#dataFrm")[0].reset();
                }
            });
        }

        //选择订单的点击事件
        $("#openOrdersWindow").click(function(){
            var index = layer.open({
                type: 1,
                title: "选择订单",
                area: ["800px","500px"],
                content: $("#selectOrdersWindow"),
                maxmin: true,
                success: function (){
                    $("#dataFrm")[0].reset();
                    url = "/admin/checkin/addCheckIn";
                    initOrdersTable();
                },

                btn: ['确认', '取消'],
                yes: function(index, layero){
                    var checkStatus = table.checkStatus('ordersTableId')
                    //判断选中行
                    if(checkStatus.data.length > 0){
                        //获取当前选中行数据
                        var data = checkStatus.data[0];
                        //进行表单数据回显
                        form.val("dataFrm",{
                            "ordersId":data.id,
                            "roomTypeId":data.roomTypeId,
                            "roomTypeName":data.roomType.typeName,
                            "roomId":data.roomId,
                            "roomNum":data.room.roomNum,
                            "customerName":data.reservationName,
                            "phone":data.phone,
                            "payPrice":data.reservePrice,
                            "arriveDate":data.arriveDate,
                            "leaveDate":data.leaveDate,
                            "idCard":data.idCard,
                            "remark":data.remark
                        });
                        layer.close(index);//关闭窗口
                    }else{
                        layer.msg("请选择表单信息");
                    }
                },
                no: function(index, layero){

                }
            });
            layer.full(index);
        });

        //登记入住的信息获取
        function initOrdersTable() {
            table.render({
                elem: '#ordersTableId',
                url: '${pageContext.request.contextPath}/admin/orders/list?status=2',
                cols: [[
                    {type: "radio", width: 50},
                    {field: 'id', width: 100, title: '预订编号', align: "center"},
                    {field: 'roomType', width: 100, title: '预订房型', align: "center",templet:function (s) {
                            return s.roomType.typeName;
                        }},
                    {field: 'room', width: 80, title: '房间号', align: "center",templet:function (s) {
                            return s.room.roomNum;
                        }},
                    {field: 'reservationName', width: 100, title: '预订人', align: "center"},
                    {field: 'idCard', width: 170, title: '身份证号', align: "center"},
                    {field: 'phone', width: 150, title: '手机号', align: "center"},
                    {field: 'status', width: 80, title: '状态', align: "center",templet:function (s) {
                            if(s.status==1){
                                return "待确定";
                            }else if(s.status==2){
                                return "已确定";
                            }else if(s.status==3){
                                return "已入住";
                            }else if(s.status==4){
                                return "已退房";
                            }
                        }},
                    {field: 'reservePrice', width: 80, title: '预订价', align: "center"},
                    {field: 'reserveDate', width: 160, title: '预订时间', align: "center"},
                    {field: 'arriveDate', width: 110, title: '入住日期', align: "center"},
                    {field: 'leaveDate', width: 110, title: '离店日期', align: "center"},
                ]],
                page: true,
            });
        }

        function checkOut(data){
            //判断当前记录状态，入住与离店
            if(data.status){
                layer.confirm('确定要办理退房吗?',{icon:3,title:'提示'},function(index){
                    $.post("/admin/checkout/addCheckOut",{"checkInId":data.id},function (result) {
                        if(result.success){
                            layer.alert(result.message,{icon:1});
                            tableIns.reload();
                        }else{
                            layer.alert(result.message,{icon:5});
                        }
                    },"json");




                    layer.close(index);
                });
            }else {
                layer.msg("该订单已办理退房请求");
            }
        }

        //提交
        form.on("submit(doSubmit)",function (data) {
            //发送ajax请求
            $.post(url,data.field,function (result) {
                if(result.success){
                    //刷新数据表格
                    tableIns.reload();
                    //关闭窗口
                    layer.close(mainIndex);
                }
                //信息反馈
                layer.msg(result.message)
            },"json")
            //禁止界面刷新
            return false;
        });

    });
</script>

</body>
</html>
