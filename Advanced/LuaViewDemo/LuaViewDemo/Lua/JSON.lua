scrW,scrH = System.screenSize();
label = Label();
label.frame(20,0,scrW,scrH-64);
label.lineCount(100);

function myprint( s )
	print(s);
	local text = label.text();
	if( text ) then
		label.text( text .. "\n" .. s);
	else
		label.text( s);
	end
end

-- 测试json字符串转成lua对象
object = Json.toTable( '{"a":false, "b":true, "c":{}, "d":0, "f":1 }' );
print(object);
myprint(Json.toString(object))


-- 测试Lua对象转成native
viewController.testJson(object);
