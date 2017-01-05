
w,h = System.screenSize();

window.backgroundColor(0x000000,1);

cellHeight = 60
image1 = "button0.png"
image2 = "button1.png"

collectionView = nil;
collectionView = CollectionView {
    Section = {
        SectionCount = 2,
        
        RowCount = function(section)
        	return 5;
        end,
        Spacing = function(section )
        	return 0;
        end,
        EdgeInsets = function(section )
        	return 20,0,0,0;
        end
    },
    Cell = {
        Id = function ( section, row )
        	if( section%2==1 ) then
        		return "ImageAndLabel";
        	else
        		return "ImageAndLabel2";
        	end
        end,
        ImageAndLabel = {
            Size = function(section, row)
				return w-10,cellHeight ;
			end,

            Init = function(cell)
            	local cellWidth ,cellHeight = cell.window.size();
            	cellHeight = cellHeight / 2;
            	cell.icon = Image();
            	cell.icon.frame(0, 0, cellHeight, cellHeight);
            
            	cell.title = Label();
            	cell.title.frame(0, cellHeight+2, cellHeight, 40);
            	cell.title.textColor(0xffFFFF);
            	cell.title.backgroundColor(0xff00ff);
            	print("构造Cell-1");
            end,

            Layout = function(cell , section, row)
					cell.icon.frame(0, 0, cellHeight, cellHeight)
					cell.icon.image(image1)
					cell.title.frame(cellHeight,0,w-cellHeight, cellHeight)
					cell.title.text("测试" .. section .. "--" .. row)
            end,

            Callback = function(cell, section, row)
            	print(section,row)
            end
        },
        ImageAndLabel2 = {
            Size = function(section, row)
				return w-10,cellHeight ;
			end,
            Init = function(cell)
            	local cellWidth ,cellHeight = cell.window.size();
            	cellHeight = cellHeight / 2;
            	cell.icon = Image();
            	cell.icon.frame(0, 0, cellHeight, cellHeight);
            
            	cell.title = Label();
            	cell.title.frame(0, cellHeight+2, cellHeight, 40);
            	cell.title.textColor(0xffFFFF);
            	cell.title.backgroundColor(0x00a4ff);
            	print("构造Cell-2");
            end,

            Layout = function(cell , section, row)
					cell.icon.frame(15, 15, cellHeight/2, cellHeight/2)
					cell.icon.image(image2)

					cell.title.frame(cellHeight,0,w-cellHeight, cellHeight)
					cell.title.text("测试" .. section .. "--" .. row)
            end,

            Callback = function(cell, section, row)
            	print(section,row)
            end
        }
    },

    Callback = {
        -- Scrolling = function( firstVisibleSection, firstVisibleRow, visibleCellCount )
        -- print("scrolling", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
        -- end,
        -- ScrollBegin = function(firstVisibleSection, firstVisibleRow, visibleCellCount )
        -- print("scrolling begin", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
        -- end,
        -- ScrollEnd = function(firstVisibleSection, firstVisibleRow, visibleCellCount )
        -- print("scrolling end", firstVisibleSection,"---" ,firstVisibleRow, "---", visibleCellCount);
        -- end
    }
};

collectionView.frame(0,0,w,h-64);
collectionView.backgroundColor(0xffFFFF);
-- collectionView.miniSpacing(10);
-- collectionView.scrollDirection(1);


