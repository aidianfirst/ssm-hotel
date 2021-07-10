<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%-- 搜索 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">部门名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="deptName" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn"  lay-submit lay-filter="data-search-btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
                            <button type="reset" class="layui-btn layui-btn-warm" ><i class=  "layui-icon layui-icon-refresh-1"></i>重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
        <%-- 头部工具栏 --%>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加</button>
            </div>
        </script>
        <%-- 表格区域 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <%-- 每行的工具栏：修改、删除 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-delete"></i>删除</a>
        </script>

        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">

                <div class="layui-form-item">
                    <label class="layui-form-label">部门名称</label>
                    <div class="layui-input-block">
                        <%-- 隐藏id --%>
                        <input type="hidden" name="id">
                        <input type="text" name="deptName" lay-verify="required" autocomplete="off"
                               placeholder="请输入部门名称" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">部门地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" lay-verify="required" autocomplete="off" placeholder="请输入部门地址"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">部门备注</label>
                    <div class="layui-input-block">
                        <textarea class="layui-textarea" name="remark" id="content"></textarea>
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

    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table','layer'], function () {
        var $ = layui.jquery,
            form = layui.form,
            layer = layui.layer;
            table = layui.table;

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/dept/list',
            toolbar: '#toolbarDemo',

            cols: [[
                {field: 'id', width: 120, title: '部门编号',align: "center"},
                {field: 'deptName', minwidth: 120, title: '部门名称',align: "center"},
                {field: 'address', minwidth: 150, title: '部门地址',align: "center"},
                {field: 'createDate', minwidth: 120, title: '创建时间',align: "center"},
                {field: 'remark', minwidth: 120, title: '备注',align: "center"},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
            //除第一页外，当前页删除最后一个数据时回到上一页
            done: function (res,curr,count) {
                //判断当前页吗是否大于1，且当前页数据量为0
                if(curr > 1 && res.data.length == 0){
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

        /**
         * toolbar监听事件
         * currentTableFilter是表格lay-filter过滤器的值
         */
        table.on("toolbar(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "add":
                    openAddWindow();
                    break;
            }
        });

        //监听行工具栏事件
        table.on("tool(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "edit":
                    openUpdateWindow(obj.data);
                    break;
                case "delete":
                    deleteById(obj.data);
                    break;
            }
        });


        var url;//提交地址
        var mainIndex;//打开窗口的索引

        // 打开添加窗口
        function openAddWindow(){
            mainIndex = layer.open({
                type: 1,
                title: "添加部门",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //清空表单数据，不然每次打开都会有上次的数据
                    $("#dataFrm")[0].reset();
                    //添加的请求
                    url = "/admin/dept/addDept";
                }
            });
        }

        function openUpdateWindow(data){
            mainIndex = layer.open({
                type: 1,
                title: "修改部门",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //表单数据回显
                    //lay-filter对象，回显数据
                    form.val("dataFrm",data);
                    //修改的请求
                    url = "/admin/dept/updateDept";
                }
            });
        }

        // 监听表单提交事件
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

        //删除部门
        function deleteById(data){
            //判断当前部门是否有员工
            $.get("/admin/dept/checkDeptHasEmployee",{"id":data.id},function (result) {
                if(result.exist){
                    //若存在员工，提示用户无法删除
                    layer.msg(result.message);
                }else {
                    //不存在员工，提示用户是否删除
                    layer.confirm("确定要删除[<font color='#ff1493'>"+data.deptName+"</font>]吗",{icon: 3,title:'警告'}, function (index) {
                        //发送ajax请求进行删除
                        $.post("/admin/dept/deleteById",{"id":data.id},function (result) {
                            if(result.success){
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            },"json");
        }
    });
</script>

</body>
</html>
