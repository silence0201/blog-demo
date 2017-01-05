scrW,scrH = System.screenSize()
window.backgroundColor(1, 0)

btnH = scrH / 12

function createButton(text, x, y , w, h, callback)
	local button  = Button() 
	button.frame(x,y,w,h)
	button.title("按钮" .. text)
	button.backgroundColor(0x00a4ff, 0.6)
	button.callback(
		function ()
			if(callback) then
				callback()
			end
		end
	)
	return button
end

button1 = createButton("关闭1", 0, btnH*1, scrW, btnH,
    function()
        Alert("标题", "内容", "确定",function(index)
                                        print("按钮ID:", index)
                                    end
        )
    end
)

button2 = createButton("关闭2", 0, btnH * 3, scrW, btnH,
                        function ()
                            Alert("Title", "Message","确定", "取消",
                                function ( index )
                                    print("按钮ID：",index)
                                end
                            )
                        end

)

button3 = createButton("关闭3", 0, btnH * 5, scrW, btnH,
                        function ()
                            Alert(nil,"Message","确定", "取消",
                                function ( index )
                                    print("按钮ID:", index)
                                end
                            )
                        end
)


