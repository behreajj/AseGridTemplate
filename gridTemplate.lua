local labelTypes <const> = {
    "LEFT",
    "RIGHT",
    "TOP",
    "BOTTOM"
}

local patternTypes <const> = {
    "DIAMOND",
    "RECTANGLE",
    "RHOMBUS"
}

local defaults <const> = {
    -- Should sliders be replaced with number inputs to give user greater
    -- flexibility on scale?
    cols = 5,
    rows = 5,
    margin = 3,
    padding = 2,
    border = 0,
    cellWidth = 32,
    cellHeight = 32,
    opacity = 255,
    patternType = "RECTANGLE",
    wChecker = 16,
    hChecker = 16,
    szDiam = 16,
    xChecker = 0,
    yChecker = 0,
    headerHeight = 0,
    labelType = "BOTTOM",
    labelSize = 0,
    genSlices = false,
    frames = 1,
    fps = 12,
    lockGrid = true,
    closeGroups = true,
    layerColorBlue01 = 43,
    layerColorBlue02 = 85,
    layerColorBlue03 = 128,
    layerColorAlpha = 85
}

local dlg <const> = Dialog { title = "Grid Template" }

dlg:slider {
    id = "cols",
    label = "Cells:",
    min = 1,
    max = 32,
    value = defaults.cols
}

dlg:slider {
    id = "rows",
    min = 1,
    max = 32,
    value = defaults.rows
}

dlg:newrow { always = false }

dlg:number {
    id = "cellWidth",
    label = "Size:",
    text = string.format("%d", defaults.cellWidth),
    decimals = 0
}

dlg:number {
    id = "cellHeight",
    text = string.format("%d", defaults.cellHeight),
    decimals = 0
}

dlg:newrow { always = false }

dlg:slider {
    id = "margin",
    label = "Margin:",
    min = 0,
    max = 32,
    value = defaults.margin
}

dlg:newrow { always = false }

dlg:slider {
    id = "padding",
    label = "Padding:",
    min = 0,
    max = 32,
    value = defaults.padding
}

dlg:newrow { always = false }

dlg:slider {
    id = "border",
    label = "Border:",
    min = 0,
    max = 32,
    value = defaults.border,
    onchange = function()
        local args <const> = dlg.data
        local sizeBorder <const> = args.border --[[@as integer]]
        local validSize <const> = sizeBorder > 0
        dlg:modify { id = "borderClr", visible = validSize }
    end
}

dlg:newrow { always = false }

dlg:color {
    id = "borderClr",
    color = Color { r = 119, g = 119, b = 119 },
    visible = defaults.border > 0
}

dlg:newrow { always = false }

dlg:combobox {
    id = "patternType",
    label = "Pattern:",
    option = defaults.patternType,
    options = patternTypes,
    onchange = function()
        local args <const> = dlg.data
        local patternType <const> = args.patternType --[[@as string]]
        local isDiam <const> = patternType == "DIAMOND"
            or patternType == "RHOMBUS"
        local isRect <const> = patternType == "RECTANGLE"
        dlg:modify { id = "szDiam", visible = isDiam }
        dlg:modify { id = "wChecker", visible = isRect }
        dlg:modify { id = "hChecker", visible = isRect }

        local validSize = false
        if isDiam then
            local szDiam <const> = args.szDiam --[[@as integer]]
            validSize = szDiam > 1
        else
            local wChecker <const> = args.wChecker --[[@as integer]]
            local hChecker <const> = args.hChecker --[[@as integer]]
            validSize = wChecker > 0 and hChecker > 0
        end
        dlg:modify { id = "bChecker", visible = validSize }
        dlg:modify { id = "xChecker", visible = validSize }
        dlg:modify { id = "yChecker", visible = validSize }
    end
}

dlg:newrow { always = false }

dlg:slider {
    id = "szDiam",
    label = "Diamond:",
    min = 4,
    max = 64,
    value = defaults.szDiam,
    visible = defaults.patternType == "DIAMOND"
        or defaults.patternType == "RHOMBUS",
    onchange = function()
        local args <const> = dlg.data
        local szDiam <const> = args.szDiam --[[@as integer]]
        local validSize <const> = szDiam > 1
        dlg:modify { id = "bChecker", visible = validSize }
        dlg:modify { id = "xChecker", visible = validSize }
        dlg:modify { id = "yChecker", visible = validSize }
    end
}

dlg:slider {
    id = "wChecker",
    label = "Checker:",
    min = 0,
    max = 64,
    value = defaults.wChecker,
    visible = defaults.patternType == "RECTANGLE",
    onchange = function()
        local args <const> = dlg.data
        local wChecker <const> = args.wChecker --[[@as integer]]
        local hChecker <const> = args.hChecker --[[@as integer]]
        local validSize <const> = wChecker > 0 and hChecker > 0
        dlg:modify { id = "bChecker", visible = validSize }
        dlg:modify { id = "xChecker", visible = validSize }
        dlg:modify { id = "yChecker", visible = validSize }
    end
}

dlg:slider {
    id = "hChecker",
    min = 0,
    max = 64,
    value = defaults.hChecker,
    visible = defaults.patternType == "RECTANGLE",
    onchange = function()
        local args <const> = dlg.data
        local wChecker <const> = args.wChecker --[[@as integer]]
        local hChecker <const> = args.hChecker --[[@as integer]]
        local validSize <const> = wChecker > 0 and hChecker > 0
        dlg:modify { id = "bChecker", visible = validSize }
        dlg:modify { id = "xChecker", visible = validSize }
        dlg:modify { id = "yChecker", visible = validSize }
    end
}

dlg:newrow { always = false }

dlg:slider {
    id = "xChecker",
    label = "Offset:",
    min = -32,
    max = 31,
    value = defaults.xChecker,
    visible = defaults.wChecker > 0
        and defaults.hChecker > 0
}

dlg:slider {
    id = "yChecker",
    min = -32,
    max = 31,
    value = defaults.yChecker,
    visible = defaults.wChecker > 0
        and defaults.hChecker > 0
}

dlg:newrow { always = false }

dlg:color {
    id = "aChecker",
    label = "Color:",
    color = Color { r = 71, g = 71, b = 71 }
}

dlg:color {
    id = "bChecker",
    color = Color { r = 96, g = 96, b = 96 },
    visible = defaults.wChecker > 0
        and defaults.hChecker > 0
}

dlg:newrow { always = false }

dlg:number {
    id = "headerHeight",
    label = "Header:",
    text = string.format("%d", defaults.headerHeight),
    decimals = 0,
    onchange = function()
        local args <const> = dlg.data
        local headerHeight <const> = args.headerHeight --[[@as number]]
        local isValid <const> = headerHeight > 0
        dlg:modify { id = "headerClr", visible = isValid }
    end
}

dlg:newrow { always = false }

dlg:color {
    id = "headerClr",
    color = Color { r = 48, g = 48, b = 48 },
    visible = defaults.headerHeight > 0
}

dlg:newrow { always = false }

dlg:combobox {
    id = "labelType",
    label = "Label:",
    option = defaults.labelType,
    options = labelTypes
}

dlg:newrow { always = false }

dlg:number {
    id = "labelSize",
    text = string.format("%d", defaults.labelSize),
    decimals = 0,
    onchange = function()
        local args <const> = dlg.data
        local labelSize <const> = args.labelSize --[[@as number]]
        local isValid <const> = labelSize > 0
        dlg:modify { id = "labelClr", visible = isValid }
    end
}

dlg:newrow { always = false }

dlg:color {
    id = "labelClr",
    color = Color { r = 48, g = 48, b = 48 },
    visible = defaults.labelSize > 0
}

dlg:newrow { always = false }

dlg:color {
    id = "bkgClr",
    label = "Background:",
    color = Color { r = 27, g = 27, b = 27 }
}

dlg:newrow { always = false }

dlg:slider {
    id = "opacity",
    label = "Opacity:",
    min = 1,
    max = 255,
    value = defaults.opacity,
    visible = false
}

dlg:newrow { always = false }

dlg:slider {
    id = "frames",
    label = "Frames:",
    min = 1,
    max = 96,
    value = defaults.frames,
    visible = false
}

dlg:newrow { always = false }

dlg:slider {
    id = "fps",
    label = "FPS:",
    min = 1,
    max = 50,
    value = defaults.fps,
    visible = false
}

dlg:newrow { always = false }

dlg:check {
    id = "genSlices",
    label = "Slices:",
    selected = defaults.genSlices,
    visible = true
}

dlg:newrow { always = false }

dlg:button {
    id = "confirm",
    text = "&OK",
    focus = true,
    onclick = function()
        local args <const> = dlg.data

        local cellWidth <const> = args.cellWidth
            or defaults.cellWidth --[[@as number]]
        local cellHeight <const> = args.cellHeight
            or defaults.cellHeight --[[@as number]]
        local cols <const> = args.cols
            or defaults.cols --[[@as integer]]
        local rows <const> = args.rows
            or defaults.rows --[[@as integer]]

        local margin <const> = args.margin
            or defaults.margin --[[@as integer]]
        local padding <const> = args.padding
            or defaults.padding --[[@as integer]]
        local border = args.border
            or defaults.border --[[@as integer]]

        local patternType <const> = args.patternType
            or defaults.patternType --[[@as string]]
        local wCheck <const> = args.wChecker
            or defaults.wChecker --[[@as integer]]
        local hCheck <const> = args.hChecker
            or defaults.hChecker --[[@as integer]]
        local szDiam <const> = args.szDiam
            or defaults.szDiam --[[@as integer]]
        local xCheck <const> = args.xChecker
            or defaults.xChecker --[[@as integer]]
        local yCheck <const> = args.yChecker
            or defaults.yChecker --[[@as integer]]

        local headerHeight <const> = args.headerHeight
            or defaults.headerHeight --[[@as number]]

        local labelType <const> = args.labelType
            or defaults.labelType --[[@as string]]
        local labelSize <const> = args.labelSize
            or defaults.labelSize --[[@as number]]

        local opacity <const> = args.opacity
            or defaults.opacity --[[@as integer]]

        local frameReqs <const> = args.frames
            or defaults.frames --[[@as integer]]
        local fps <const> = args.fps
            or defaults.fps --[[@as integer]]

        local genSlices = args.genSlices --[[@as boolean]]

        local aChecker <const> = args.aChecker --[[@as Color]]
        local bChecker <const> = args.bChecker --[[@as Color]]
        local bkgClr <const> = args.bkgClr --[[@as Color]]
        local borderClr <const> = args.borderClr --[[@as Color]]
        local headerClr <const> = args.headerClr --[[@as Color]]
        local labelClr <const> = args.labelClr --[[@as Color]]

        local editGrid <const> = not defaults.lockGrid
        local closeGroups <const> = defaults.closeGroups

        local layerColorBlue01 <const> = defaults.layerColorBlue01
        local layerColorBlue02 <const> = defaults.layerColorBlue02
        local layerColorBlue03 <const> = defaults.layerColorBlue03
        local layerColorAlpha <const> = defaults.layerColorAlpha

        local cwVrf <const> = math.max(2,
            math.floor(0.5 + math.abs(cellWidth)))
        local chVrf <const> = math.max(2,
            math.floor(0.5 + math.abs(cellHeight)))
        local headVrf <const> = math.max(0,
            math.floor(0.5 + math.abs(headerHeight)))
        local labelVrf <const> = math.max(0,
            math.floor(0.5 + math.abs(labelSize)))

        local margin2 <const> = margin + margin
        local border2 <const> = border + border
        local colsn1 <const> = cols - 1
        local rowsn1 <const> = rows - 1
        local flatLen <const> = rows * cols

        local useHeader <const> = headVrf > 0
        local useBkg <const> = bkgClr.alpha > 0
        local useBdr <const> = borderClr.alpha > 0 and border > 0
        local useLabel <const> = labelVrf > 0
        local oneFrame <const> = frameReqs <= 1
        if not useBdr then border = 0 end

        local xGridOffset <const> = margin
        local yGridOffset = margin
        if useHeader then
            yGridOffset = margin
                + padding + headVrf
        end

        local rowToGreen = 0.0
        local colToRed = 0.0
        if rowsn1 ~= 0 then rowToGreen = 255.0 / rowsn1 end
        if colsn1 ~= 0 then colToRed = 255.0 / colsn1 end

        local aHex <const> = aChecker.rgbaPixel | 0xff000000
        local bHex <const> = bChecker.rgbaPixel | 0xff000000
        local bkgHex <const> = bkgClr.rgbaPixel | 0xff000000

        -- This has to be copied in case a color is chosen by index, then
        -- the referenced color changes when new sprite is created.
        local rBorderClr <const> = borderClr.red
        local gBorderClr <const> = borderClr.green
        local bBorderClr <const> = borderClr.blue

        -- Update whenever new elements are added to a cell.
        local wCellTotal = cwVrf + border2
        local hCellTotal = chVrf + border2
        if useLabel then
            if labelType == "LEFT"
                or labelType == "RIGHT" then
                wCellTotal = wCellTotal + labelVrf
            elseif labelType == "TOP"
                or labelType == "BOTTOM" then
                hCellTotal = hCellTotal + labelVrf
            end
        end

        local spriteWidth <const> = margin2
            + wCellTotal * cols
            + padding * colsn1
        local spriteHeight = margin2
            + hCellTotal * rows
            + padding * rowsn1
        if useHeader then
            spriteHeight = spriteHeight
                + headVrf
                + padding
        end

        -- As a precaution against crashes, do not allow slices UI interface
        -- to be active.
        local appTool <const> = app.tool
        if appTool then
            local toolName <const> = appTool.id
            if toolName == "slice" then
                app.tool = "hand"
            end
        end

        local activeSprite <const> = Sprite(spriteWidth, spriteHeight)
        activeSprite.filename = "Grid"

        app.transaction("Set Grid Bounds", function()
            local wGrid <const> = cols > 1
                and wCellTotal + padding
                or wCellTotal
            local hGrid <const> = rows > 1
                and hCellTotal + padding
                or hCellTotal

            activeSprite.gridBounds = Rectangle(
                xGridOffset, yGridOffset,
                wGrid, hGrid)
        end)

        -- Ase a precaution against any crashes, do not use defaultPalette.
        app.transaction("Set Palette", function()
            local palette <const> = activeSprite.palettes[1]
            palette:resize(10)
            palette:setColor(0, Color { r = 0, g = 0, b = 0, a = 0 })
            palette:setColor(1, Color { r = 0, g = 0, b = 0, a = 255 })
            palette:setColor(2, Color { r = 255, g = 255, b = 255, a = 255 })
            palette:setColor(3, Color { r = 254, g = 91, b = 89, a = 255 })
            palette:setColor(4, Color { r = 247, g = 165, b = 71, a = 255 })
            palette:setColor(5, Color { r = 243, g = 206, b = 82, a = 255 })
            palette:setColor(6, Color { r = 106, g = 205, b = 91, a = 255 })
            palette:setColor(7, Color { r = 87, g = 185, b = 242, a = 255 })
            palette:setColor(8, Color { r = 209, g = 134, b = 223, a = 255 })
            palette:setColor(9, Color { r = 165, g = 165, b = 167, a = 255 })
        end)

        local activeLayer <const> = activeSprite.layers[1]
        local spriteSpec <const> = activeSprite.spec
        local checkSpec <const> = ImageSpec(spriteSpec)
        checkSpec.width = cwVrf
        checkSpec.height = chVrf
        local checkImage <const> = Image(checkSpec)

        local validColorDiff <const> = aHex ~= bHex
        local validChecker <const> = validColorDiff
            and patternType == "RECTANGLE"
            and wCheck >= 1
            and hCheck >= 1
        local validDiamond <const> = validColorDiff
            and (patternType == "DIAMOND"
                or patternType == "RHOMBUS")
            and szDiam >= 4

        -- TODO: Replace with string bytes...
        local pxItr <const> = checkImage:pixels()
        if validDiamond then
            local yScale = 1
            if patternType == "RHOMBUS" then yScale = 2 end
            local halfSize <const> = szDiam * 0.5
            local abs <const> = math.abs
            for pixel in pxItr do
                local xPx <const> = pixel.x - xCheck
                local yPx <const> = yScale * (pixel.y - yCheck)
                local xLocal <const> = xPx % szDiam
                local yLocal <const> = yPx % szDiam
                local manhDist <const> = abs(xLocal - halfSize)
                    + abs(yLocal - halfSize)
                local hex <const> = manhDist <= halfSize and aHex or bHex
                pixel(hex)
            end
        elseif validChecker then
            for pixel in pxItr do
                local xPx <const> = pixel.x - xCheck
                local yPx <const> = pixel.y - yCheck
                local hex = bHex
                if ((xPx // wCheck + yPx // hCheck) % 2) ~= 1 then
                    hex = aHex
                end
                pixel(hex)
            end
        else
            checkImage:clear(aHex)
        end

        local labelImage = nil
        local xLabelDisplace = 0
        local yLabelDisplace = 0
        local xLabelLoc = 0
        local yLabelLoc = 0
        if useLabel then
            local wLabel = 0
            local hLabel = 0
            if labelType == "LEFT" then
                xLabelDisplace = labelVrf
                wLabel = labelVrf
                hLabel = hCellTotal
            elseif labelType == "RIGHT" then
                xLabelLoc = cwVrf + border2
                wLabel = labelVrf
                hLabel = hCellTotal
            elseif labelType == "TOP" then
                yLabelDisplace = labelVrf
                wLabel = wCellTotal
                hLabel = labelVrf
            elseif labelType == "BOTTOM" then
                yLabelLoc = chVrf + border2
                wLabel = wCellTotal
                hLabel = labelVrf
            end

            local labelSpec <const> = ImageSpec(spriteSpec)
            labelSpec.width = wLabel
            labelSpec.height = hLabel
            labelImage = Image(labelSpec)

            if labelClr.alpha > 0 then
                local labelHex <const> = labelClr.rgbaPixel | 0xff000000
                labelImage:clear(labelHex)
            end
        end

        local bdrImage = nil
        if useBdr then
            local bdrSpec <const> = ImageSpec(spriteSpec)
            local wBordered <const> = cwVrf + border2
            local hBordered <const> = chVrf + border2
            bdrSpec.width = wBordered
            bdrSpec.height = hBordered
            bdrImage = Image(bdrSpec)

            local highStr <const> = string.pack("B B B B",
                rBorderClr,
                gBorderClr,
                bBorderClr,
                255)
            local zeroStr <const> = string.pack("B B B B", 0, 0, 0, 0)

            ---@type string[]
            local byteStrs <const> = {}
            local horizStripWeight <const> = cwVrf + border
            local vertStripWeight <const> = chVrf + border
            local horizStripArea <const> = border * horizStripWeight
            local vertStripArea <const> = border * vertStripWeight

            -- Draw top and bottom horizontal strips.
            local i = 0
            while i < horizStripArea do
                local xh <const> = i % horizStripWeight
                local yh <const> = i // horizStripWeight

                local xTop <const> = xh
                local yTop <const> = yh
                local idxTop <const> = xTop + yTop * wBordered
                byteStrs[1 + idxTop] = highStr

                local xBtm <const> = xh + border
                local yBtm <const> = yh + vertStripWeight
                local idxBtm <const> = xBtm + yBtm * wBordered
                byteStrs[1 + idxBtm] = highStr

                i = i + 1
            end

            -- Draw left and right vertical strips.
            local j = 0
            while j < vertStripArea do
                local x <const> = j % border
                local y <const> = j // border

                local xLft <const> = x
                local yLft <const> = y + border
                local idxLft <const> = xLft + yLft * wBordered
                byteStrs[1 + idxLft] = highStr

                local xRgt <const> = x + horizStripWeight
                local yRgt <const> = y
                local idxRgt <const> = xRgt + yRgt * wBordered
                byteStrs[1 + idxRgt] = highStr

                j = j + 1
            end

            -- Draw clear center.
            local lenVrf <const> = cwVrf * chVrf
            local k = 0
            while k < lenVrf do
                local x <const> = border + k % cwVrf
                local y <const> = border + k // cwVrf
                local idxCenter <const> = x + y * wBordered
                byteStrs[1 + idxCenter] = zeroStr
                k = k + 1
            end

            bdrImage.bytes = table.concat(byteStrs)
        end

        local gridGroup <const> = activeSprite:newGroup()
        app.transaction("Set Grid Group Props", function()
            gridGroup.name = string.format(
                "Grid %d x %d",
                cols, rows)
            gridGroup.stackIndex = 1
            gridGroup.isCollapsed = closeGroups
            gridGroup.isEditable = editGrid
        end)

        local bkgLayer <const> = activeSprite:newLayer()
        local bkgImage <const> = Image(spriteSpec)
        bkgImage:clear(bkgHex)
        if useBkg then
            app.transaction("Set Bkg Props", function()
                bkgLayer.name = "Bkg"
                bkgLayer.parent = gridGroup
                bkgLayer.opacity = opacity
                bkgLayer.isEditable = editGrid
                bkgLayer.isContinuous = oneFrame
            end)
        end

        local headLayer = nil
        local headImage = nil
        if useHeader then
            local headSpec <const> = ImageSpec(spriteSpec)
            headSpec.width = wCellTotal * cols
                + padding * colsn1
            headSpec.height = headVrf
            headImage = Image(headSpec)
            if headerClr.alpha > 0 then
                local headHex <const> = headerClr.rgbaPixel | 0xff000000
                headImage:clear(headHex)
            end

            headLayer = activeSprite:newLayer()
            app.transaction("Set Header Props", function()
                headLayer.name = "Header"
                headLayer.parent = gridGroup
                headLayer.opacity = opacity
                headLayer.isEditable = editGrid
                headLayer.isContinuous = oneFrame
            end)
        end

        -- Cache methods used in loops.
        local floor <const> = math.floor
        local strfmt <const> = string.format
        local transact <const> = app.transaction

        ---@type Point[]
        local labelPoints <const> = {}
        ---@type Layer[]
        local labelLayers <const> = {}

        ---@type Point[]
        local bdrPoints <const> = {}
        ---@type Layer[]
        local bdrLayers <const> = {}

        ---@type Point[]
        local checkPoints <const> = {}
        ---@type Layer[]
        local checkLayers <const> = {}

        local row = rows
        while row > 0 do
            row = row - 1

            local yOffset <const> = yGridOffset + row * padding
            local y <const> = row * hCellTotal + yOffset
            local green <const> = floor(row * rowToGreen + 0.5)

            local rowColor <const> = Color {
                r = 128,
                g = green,
                b = 0,
                a = layerColorAlpha
            }

            local rowGroup <const> = activeSprite:newGroup()
            local rowName <const> = strfmt("Row %02d", 1 + row)
            transact("Set Row Props", function()
                rowGroup.name = rowName
                rowGroup.parent = gridGroup
                rowGroup.isCollapsed = closeGroups
                rowGroup.isEditable = editGrid
                rowGroup.color = rowColor
            end)

            transact("Create Columns", function()
                local col = cols
                while col > 0 do
                    col = col - 1

                    local xOffset <const> = xGridOffset + col * padding
                    local x <const> = col * wCellTotal + xOffset
                    local red <const> = floor(col * colToRed + 0.5)

                    local idxFlat <const> = col + row * cols
                    local idxReverse <const> = flatLen - idxFlat

                    local colColor <const> = Color {
                        r = red,
                        g = green,
                        b = 0,
                        a = layerColorAlpha
                    }

                    local colGroup <const> = activeSprite:newGroup()
                    colGroup.name = strfmt("Column %02d %02d", 1 + col, 1 + row)
                    colGroup.parent = rowGroup
                    colGroup.isCollapsed = closeGroups
                    colGroup.isEditable = editGrid
                    colGroup.color = colColor

                    if useLabel then
                        local labelColor <const> = Color {
                            r = red,
                            g = green,
                            b = layerColorBlue03,
                            a = layerColorAlpha
                        }

                        local labelLayer <const> = activeSprite:newLayer()
                        labelLayer.name = strfmt("Label %04d", 1 + idxFlat)
                        labelLayer.parent = colGroup
                        labelLayer.isContinuous = oneFrame
                        labelLayer.opacity = opacity
                        labelLayer.isEditable = editGrid
                        labelLayer.color = labelColor

                        labelPoints[idxReverse] = Point(
                            xLabelLoc + x,
                            yLabelLoc + y)
                        labelLayers[idxReverse] = labelLayer
                    end

                    local checkColor <const> = Color {
                        r = red,
                        g = green,
                        b = layerColorBlue02,
                        a = layerColorAlpha
                    }

                    local checkLayer <const> = activeSprite:newLayer()
                    checkLayer.name = strfmt("Checker %04d", 1 + idxFlat)
                    checkLayer.parent = colGroup
                    checkLayer.isContinuous = oneFrame
                    checkLayer.isEditable = editGrid
                    checkLayer.opacity = opacity
                    checkLayer.color = checkColor

                    checkPoints[idxReverse] = Point(
                        xLabelDisplace + border + x,
                        yLabelDisplace + border + y)
                    checkLayers[idxReverse] = checkLayer

                    if useBdr then
                        local bdrColor <const> = Color {
                            r = red,
                            g = green,
                            b = layerColorBlue01,
                            a = layerColorAlpha
                        }

                        local bdrLayer <const> = activeSprite:newLayer()
                        bdrLayer.name = strfmt("Border %04d", 1 + idxFlat)
                        bdrLayer.parent = colGroup
                        bdrLayer.isContinuous = oneFrame
                        bdrLayer.opacity = opacity
                        bdrLayer.isEditable = editGrid
                        bdrLayer.color = bdrColor

                        bdrPoints[idxReverse] = Point(
                            xLabelDisplace + x,
                            yLabelDisplace + y)
                        bdrLayers[idxReverse] = bdrLayer
                    end
                end
            end)
        end

        local firstFrame <const> = activeSprite.frames[1]
        local duration <const> = 1.0 / math.max(1, fps)

        if not oneFrame then
            app.transaction("Create Frames", function()
                firstFrame.duration = duration
                local g = 1
                while g < frameReqs do
                    g = g + 1
                    local frObj <const> = activeSprite:newEmptyFrame()
                    frObj.duration = duration
                end
            end)
        else
            app.transaction("Set Frame Duration", function()
                firstFrame.duration = duration
            end)
        end

        local lenFrames <const> = #activeSprite.frames
        local gridFlat <const> = cols * rows

        if useBkg then
            app.transaction("Create Bkg Cels", function()
                local h = 0
                while h < lenFrames do
                    h = h + 1
                    local bkgCel <const> = activeSprite:newCel(
                        bkgLayer, h, bkgImage)
                    bkgCel.zIndex = -32768
                end
            end)
        end

        if useHeader and headLayer then
            local headLoc <const> = Point(margin, margin)
            app.transaction("Create Header Cels", function()
                local h = 0
                while h < lenFrames do
                    h = h + 1
                    local headCel <const> = activeSprite:newCel(
                        headLayer, h, headImage, headLoc)
                    headCel.zIndex = -32767
                end
            end)
        end

        local i = 0
        while i < gridFlat do
            i = i + 1

            if useLabel then
                local labelPoint <const> = labelPoints[i]
                local labelLayer <const> = labelLayers[i]

                app.transaction("Create Label Cel", function()
                    local j = 0
                    while j < lenFrames do
                        j = j + 1
                        local labelCel <const> = activeSprite:newCel(
                            labelLayer, j, labelImage, labelPoint)
                        labelCel.zIndex = -32766
                    end
                end)
            end

            local checkPoint <const> = checkPoints[i]
            local checkLayer <const> = checkLayers[i]

            app.transaction("Create Checker Cel", function()
                local m = 0
                while m < lenFrames do
                    m = m + 1
                    local checkCel <const> = activeSprite:newCel(
                        checkLayer, m, checkImage, checkPoint)
                    checkCel.zIndex = -32765
                end
            end)

            if useBdr then
                local bdrPoint <const> = bdrPoints[i]
                local bdrLayer <const> = bdrLayers[i]

                app.transaction("Create Border Cel", function()
                    local k = 0
                    while k < lenFrames do
                        k = k + 1
                        local bdrCel <const> = activeSprite:newCel(
                            bdrLayer, k, bdrImage, bdrPoint)
                        bdrCel.zIndex = -32764
                    end
                end)
            end
        end

        if genSlices then
            local sliceColor = Color { r = 255, g = 255, b = 255, a = 255 }
            local appPrefs <const> = app.preferences
            if appPrefs then
                local slicePrefs <const> = appPrefs.slices
                if slicePrefs then
                    local prefsColor <const> = slicePrefs.default_color --[[@as Color]]
                    if prefsColor then
                        if prefsColor.alpha > 0 then
                            sliceColor = Color {
                                r = prefsColor.red,
                                g = prefsColor.green,
                                b = prefsColor.blue,
                                a = prefsColor.alpha,
                            }
                        end
                    end
                end
            end

            local slicePivot <const> = Point(cwVrf // 2, chVrf // 2)
            local sliceInset <const> = Rectangle(0, 0, cwVrf, chVrf)

            app.transaction("Create Slices", function()
                local j = 0
                while j < gridFlat do
                    j = j + 1
                    local sliceName <const> = strfmt("Slice %04d",
                        gridFlat + 1 - j)
                    local checkPoint <const> = checkPoints[j]
                    local slice <const> = activeSprite:newSlice(Rectangle(
                        checkPoint.x, checkPoint.y,
                        cwVrf, chVrf))
                    slice.name = sliceName
                    slice.color = sliceColor
                    slice.pivot = slicePivot
                    slice.center = sliceInset
                end
            end)
        end

        app.frame = firstFrame
        app.layer = activeLayer

        -- Onion skin defaults need to be adjusted to work well with grid.
        -- Position 1 is In front of sprite.
        -- Type 1 is Red/Blue Tint.
        local appPrefs <const> = app.preferences
        if appPrefs then
            local docPrefs <const> = appPrefs.document(activeSprite)
            if docPrefs then
                local onionSkinPrefs <const> = docPrefs.onionskin
                if onionSkinPrefs then
                    onionSkinPrefs.loop_tag = false
                    onionSkinPrefs.current_layer = true
                    onionSkinPrefs.position = 1
                    onionSkinPrefs.type = 1
                end

                local thumbPrefs <const> = docPrefs.thumbnails
                if thumbPrefs then
                    thumbPrefs.enabled = true
                    thumbPrefs.zoom = 1
                    thumbPrefs.overlay_enabled = true
                end
            end
        end

        -- Under Edit > Preferences > Editor, there's an option to fit to
        -- screen on sprite open which seems to take care of this if users
        -- wish. The issue is that different downsampling algorithms make
        -- screen fit more or less preferable.
        -- app.command.FitScreen()
        app.refresh()
        dlg:close()
    end
}

dlg:button {
    id = "cancel",
    text = "&CANCEL",
    focus = false,
    onclick = function()
        dlg:close()
    end
}

dlg:show {
    autoscrollbars = true,
    wait = false
}