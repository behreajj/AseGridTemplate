local labelTypes = {
    "LEFT",
    "RIGHT",
    "TOP",
    "BOTTOM"
}

local defaults = {
    -- Should sliders be replaced with number
    -- inputs to give user greater flexibility
    -- on scale?
    cols = 5,
    rows = 5,
    margin = 3,
    padding = 2,
    border = 0,
    cellWidth = 32,
    cellHeight = 32,
    opacity = 255,
    wChecker = 16,
    hChecker = 16,
    xChecker = 0,
    yChecker = 0,
    headerHeight = 0,
    labelType = "BOTTOM",
    labelSize = 0,
    frames = 1,
    fps = 12,
    lockGrid = true,
    closeGroups = true,
    layerColorBlue01 = 43,
    layerColorBlue02 = 85,
    layerColorBlue03 = 128,
    layerColorAlpha = 85
}

local dlg = Dialog { title = "Grid Template" }

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
        local args = dlg.data
        local sizeBorder = args.border
        local validSize = sizeBorder > 0
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

dlg:slider {
    id = "wChecker",
    label = "Checker:",
    min = 0,
    max = 64,
    value = defaults.wChecker,
    onchange = function()
        local args = dlg.data
        local wChecker = args.wChecker --[[@as integer]]
        local hChecker = args.hChecker --[[@as integer]]
        local validSize = wChecker > 0 and hChecker > 0
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
    onchange = function()
        local args = dlg.data
        local wChecker = args.wChecker --[[@as integer]]
        local hChecker = args.hChecker --[[@as integer]]
        local validSize = wChecker > 0 and hChecker > 0
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
    visible = false,
    onchange = function()
        local args = dlg.data
        local headerHeight = args.headerHeight --[[@as number]]
        local isValid = headerHeight > 0
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
        local args = dlg.data
        local labelSize = args.labelSize --[[@as number]]
        local isValid = labelSize > 0
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

dlg:button {
    id = "confirm",
    text = "&OK",
    focus = true,
    onclick = function()
        local args = dlg.data

        local cellWidth = args.cellWidth
            or defaults.cellWidth --[[@as number]]
        local cellHeight = args.cellHeight
            or defaults.cellHeight --[[@as number]]
        local cols = args.cols
            or defaults.cols --[[@as integer]]
        local rows = args.rows
            or defaults.rows --[[@as integer]]

        local margin = args.margin
            or defaults.margin --[[@as integer]]
        local padding = args.padding
            or defaults.padding --[[@as integer]]
        local border = args.border
            or defaults.border --[[@as integer]]

        local wCheck = args.wChecker
            or defaults.wChecker --[[@as integer]]
        local hCheck = args.hChecker
            or defaults.hChecker --[[@as integer]]
        local xCheck = args.xChecker
            or defaults.xChecker --[[@as integer]]
        local yCheck = args.yChecker
            or defaults.yChecker --[[@as integer]]

        local headerHeight = args.headerHeight
            or defaults.headerHeight --[[@as number]]

        local labelType = args.labelType
            or defaults.labelType --[[@as string]]
        local labelSize = args.labelSize
            or defaults.labelSize --[[@as number]]

        local opacity = args.opacity
            or defaults.opacity --[[@as integer]]

        local frameReqs = args.frames
            or defaults.frames --[[@as integer]]
        local fps = args.fps
            or defaults.fps --[[@as integer]]

        local aChecker = args.aChecker --[[@as Color]]
        local bChecker = args.bChecker --[[@as Color]]
        local bkgClr = args.bkgClr --[[@as Color]]
        local borderClr = args.borderClr --[[@as Color]]
        local headerClr = args.headerClr --[[@as Color]]
        local labelClr = args.labelClr --[[@as Color]]

        local editGrid = not defaults.lockGrid
        local closeGroups = defaults.closeGroups

        local layerColorBlue01 = defaults.layerColorBlue01
        local layerColorBlue02 = defaults.layerColorBlue02
        local layerColorBlue03 = defaults.layerColorBlue03
        local layerColorAlpha = defaults.layerColorAlpha

        local cwVrf = math.max(2,
            math.floor(0.5 + math.abs(cellWidth)))
        local chVrf = math.max(2,
            math.floor(0.5 + math.abs(cellHeight)))
        local headVrf = math.max(0,
            math.floor(0.5 + math.abs(headerHeight)))
        local labelVrf = math.max(0,
            math.floor(0.5 + math.abs(labelSize)))

        local margin2 = margin + margin
        local border2 = border + border
        local colsn1 = cols - 1
        local rowsn1 = rows - 1
        local flatLen = rows * cols

        local useHeader = headVrf > 0
        local useBkg = bkgClr.alpha > 0
        local useBdr = borderClr.alpha > 0 and border > 0
        local useLabel = labelVrf > 0
        local oneFrame = frameReqs <= 1
        if not useBdr then border = 0 end

        local xGridOffset = margin
        local yGridOffset = margin
        if useHeader then
            yGridOffset = margin
                + padding + headVrf
        end

        local rowToGreen = 0.0
        local colToRed = 0.0
        if rowsn1 ~= 0 then rowToGreen = 255.0 / rowsn1 end
        if colsn1 ~= 0 then colToRed = 255.0 / colsn1 end

        local aHex = aChecker.rgbaPixel | 0xff000000
        local bHex = bChecker.rgbaPixel | 0xff000000
        local bkgHex = bkgClr.rgbaPixel | 0xff000000

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

        local spriteWidth = margin2
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
        local activeSprite = Sprite(spriteWidth, spriteHeight)
        local activeLayer = activeSprite.layers[1]
        app.command.LoadPalette { preset = "default" }

        local spriteSpec = activeSprite.spec
        local checkSpec = ImageSpec(spriteSpec)
        checkSpec.width = cwVrf
        checkSpec.height = chVrf
        local checkImage = Image(checkSpec)

        if wCheck > 0 and hCheck > 0 and aHex ~= bHex then
            local pxItr = checkImage:pixels()
            for pixel in pxItr do
                local xPx = pixel.x - xCheck
                local yPx = pixel.y - yCheck
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

            local labelSpec = ImageSpec(spriteSpec)
            labelSpec.width = wLabel
            labelSpec.height = hLabel
            labelImage = Image(labelSpec)

            if labelClr.alpha > 0 then
                local labelHex = labelClr.rgbaPixel | 0xff000000
                labelImage:clear(labelHex)
            end
        end

        local bdrImage = nil
        if useBdr then
            local bdrHex = borderClr.rgbaPixel | 0xff000000

            local bdrSpec = ImageSpec(spriteSpec)
            local wBordered = cwVrf + border2
            local hBordered = chVrf + border2
            bdrSpec.width = wBordered
            bdrSpec.height = hBordered
            bdrImage = Image(bdrSpec)

            local topRect = Rectangle(
                0, 0,
                wBordered - border, border)
            local topItr = bdrImage:pixels(topRect)
            for pixel in topItr do pixel(bdrHex) end

            local rgtRect = Rectangle(
                wBordered - border, 0,
                border, hBordered - border)
            local rgtItr = bdrImage:pixels(rgtRect)
            for pixel in rgtItr do pixel(bdrHex) end

            local btmRect = Rectangle(
                border, hBordered - border,
                wBordered - border, border)
            local btmItr = bdrImage:pixels(btmRect)
            for pixel in btmItr do pixel(bdrHex) end

            local lftRect = Rectangle(
                0, border,
                border, hBordered - border)
            local lftItr = bdrImage:pixels(lftRect)
            for pixel in lftItr do pixel(bdrHex) end
        end

        local gridGroup = nil
        app.transaction(function()
            gridGroup = activeSprite:newGroup()
            gridGroup.name = string.format(
                "Grid %d x %d",
                cols, rows)
            gridGroup.stackIndex = 1
            gridGroup.isCollapsed = closeGroups
            gridGroup.isEditable = editGrid
        end)

        local bkgLayer = nil
        local bkgImage = Image(spriteSpec)
        bkgImage:clear(bkgHex)
        if useBkg then
            app.transaction(function()
                bkgLayer = activeSprite:newLayer()
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
            local headSpec = ImageSpec(spriteSpec)
            headSpec.width = wCellTotal * cols
                + padding * colsn1
            headSpec.height = headVrf
            headImage = Image(headSpec)
            if headerClr.alpha > 0 then
                local headHex = headerClr.rgbaPixel | 0xff000000
                headImage:clear(headHex)
            end

            app.transaction(function()
                headLayer = activeSprite:newLayer()
                headLayer.name = "Header"
                headLayer.parent = gridGroup
                headLayer.opacity = opacity
                headLayer.isEditable = editGrid
                headLayer.isContinuous = oneFrame
            end)
        end

        -- Cache methods used in loops.
        local floor = math.floor
        local strfmt = string.format
        local transact = app.transaction

        ---@type Point[]
        local labelPoints = {}
        ---@type Layer[]
        local labelLayers = {}

        ---@type Point[]
        local bdrPoints = {}
        ---@type Layer[]
        local bdrLayers = {}

        ---@type Point[]
        local checkPoints = {}
        ---@type Layer[]
        local checkLayers = {}

        local row = rows
        while row > 0 do
            row = row - 1

            local yOffset = yGridOffset + row * padding
            local y = row * hCellTotal + yOffset
            local green = floor(row * rowToGreen + 0.5)

            local rowColor = Color {
                r = 128,
                g = green,
                b = 0,
                a = layerColorAlpha
            }

            local rowGroup = nil
            local rowName = strfmt("Row %02d", 1 + row)
            transact(function()
                rowGroup = activeSprite:newGroup()
                rowGroup.name = rowName
                rowGroup.parent = gridGroup
                rowGroup.isCollapsed = closeGroups
                rowGroup.isEditable = editGrid
                rowGroup.color = rowColor
            end)

            transact(function()
                local col = cols
                while col > 0 do
                    col = col - 1

                    local xOffset = xGridOffset + col * padding
                    local x = col * wCellTotal + xOffset
                    local red = floor(col * colToRed + 0.5)

                    local colColor = Color {
                        r = red,
                        g = green,
                        b = 0,
                        a = layerColorAlpha
                    }

                    local colGroup = nil
                    colGroup = activeSprite:newGroup()
                    colGroup.name = strfmt(
                        "Column %02d %02d",
                        1 + col, 1 + row)
                    colGroup.parent = rowGroup
                    colGroup.isCollapsed = closeGroups
                    colGroup.isEditable = editGrid
                    colGroup.color = colColor

                    local idxFlat = col + row * cols
                    local idxReverse = flatLen - idxFlat

                    if useLabel then
                        local labelColor = Color {
                            r = red,
                            g = green,
                            b = layerColorBlue03,
                            a = layerColorAlpha
                        }

                        local labelLayer = nil
                        labelLayer = activeSprite:newLayer()
                        labelLayer.name = strfmt(
                            "Label %04d", 1 + idxFlat)
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

                    local checkColor = Color {
                        r = red,
                        g = green,
                        b = layerColorBlue02,
                        a = layerColorAlpha
                    }

                    local checkLayer = nil
                    checkLayer = activeSprite:newLayer()
                    checkLayer.name = strfmt(
                        "Checker %04d", 1 + idxFlat)
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
                        local bdrColor = Color {
                            r = red,
                            g = green,
                            b = layerColorBlue01,
                            a = layerColorAlpha
                        }

                        local bdrLayer = nil
                        bdrLayer = activeSprite:newLayer()
                        bdrLayer.name = strfmt(
                            "Border %04d", 1 + idxFlat)
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

        local firstFrame = activeSprite.frames[1]
        local duration = 1.0 / math.max(1, fps)

        if not oneFrame then
            app.transaction(function()
                firstFrame.duration = duration
                local g = 1
                while g < frameReqs do
                    g = g + 1
                    local frObj = activeSprite:newEmptyFrame()
                    frObj.duration = duration
                end
            end)
        else
            firstFrame.duration = duration
        end

        local lenFrames = #activeSprite.frames
        local gridFlat = cols * rows

        if useBkg then
            app.transaction(function()
                local h = 0
                while h < lenFrames do
                    h = h + 1
                    activeSprite:newCel(bkgLayer, h, bkgImage)
                end
            end)
        end

        if useHeader then
            local headLoc = Point(margin, margin)
            app.transaction(function()
                local h = 0
                while h < lenFrames do
                    h = h + 1
                    activeSprite:newCel(headLayer, h, headImage, headLoc)
                end
            end)
        end

        local i = 0
        while i < gridFlat do
            i = i + 1

            if useLabel then
                local labelPoint = labelPoints[i]
                local labelLayer = labelLayers[i]

                app.transaction(function()
                    local j = 0
                    while j < lenFrames do
                        j = j + 1
                        activeSprite:newCel(
                            labelLayer, j, labelImage, labelPoint)
                    end
                end)
            end

            local checkPoint = checkPoints[i]
            local checkLayer = checkLayers[i]

            app.transaction(function()
                local m = 0
                while m < lenFrames do
                    m = m + 1
                    activeSprite:newCel(
                        checkLayer, m, checkImage, checkPoint)
                end
            end)

            if useBdr then
                local bdrPoint = bdrPoints[i]
                local bdrLayer = bdrLayers[i]

                app.transaction(function()
                    local k = 0
                    while k < lenFrames do
                        k = k + 1
                        activeSprite:newCel(
                            bdrLayer, k, bdrImage, bdrPoint)
                    end
                end)
            end
        end

        activeSprite.filename = "Grid"
        activeSprite.gridBounds = Rectangle(
            xGridOffset, yGridOffset,
            wCellTotal + padding,
            hCellTotal + padding)

        app.activeFrame = firstFrame
        app.activeLayer = activeLayer
        app.command.FitScreen()
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

dlg:show { wait = false }