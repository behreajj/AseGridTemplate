local defaults = {
    cols = 5,
    rows = 5,
    margin = 4,
    padding = 2,
    border = 0,
    cellWidth = 32,
    cellHeight = 32,
    opacity = 255,
    lockGrid = true,
    collapseGrid = true,
    wChecker = 16,
    hChecker = 16,
    xChecker = 0,
    yChecker = 0,
    layerColorBlue01 = 64,
    layerColorBlue02 = 128,
    frames = 1,
    fps = 12,
    layerColorAlpha = 96
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
    -- One less step is 94 for another color.
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
    end
}

dlg:newrow { always = false }

dlg:slider {
    id = "xChecker",
    label = "Offset:",
    min = -32,
    max = 31,
    value = defaults.xChecker,
}

dlg:slider {
    id = "yChecker",
    min = -32,
    max = 31,
    value = defaults.yChecker,
}

dlg:newrow { always = false }

dlg:color {
    id = "aChecker",
    label = "Color:",
    color = Color { r = 48, g = 48, b = 48 }
}

dlg:color {
    id = "bChecker",
    color = Color { r = 71, g = 71, b = 71 },
    visible = defaults.wChecker > 0
        and defaults.hChecker > 0
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
    value = defaults.frames
}

dlg:newrow { always = false }

dlg:slider {
    id = "fps",
    label = "FPS:",
    min = 1,
    max = 50,
    value = defaults.fps
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

        local opacity = args.opacity
            or defaults.opacity --[[@as integer]]

        local frameReqs = args.frames
            or defaults.frames --[[@as integer]]
        local fps = args.fps
            or defaults.fps --[[@as integer]]

        local layerColorBlue01 = defaults.layerColorBlue01
        local layerColorBlue02 = defaults.layerColorBlue02
        local layerColorAlpha = defaults.layerColorAlpha

        local aChecker = args.aChecker --[[@as Color]]
        local bChecker = args.bChecker --[[@as Color]]
        local bkgClr = args.bkgClr --[[@as Color]]
        local borderClr = args.borderClr --[[@as Color]]

        local cwVrf = math.max(2,
            math.floor(0.5 + math.abs(cellWidth)))
        local chVrf = math.max(2,
            math.floor(0.5 + math.abs(cellHeight)))

        local margin2 = margin + margin
        local border2 = border + border
        local colsn1 = cols - 1
        local rowsn1 = rows - 1

        local rowToGreen = 0.0
        local colToRed = 0.0
        if rowsn1 ~= 0 then rowToGreen = 255.0 / rowsn1 end
        if colsn1 ~= 0 then colToRed = 255.0 / colsn1 end

        local useBkg = bkgClr.alpha > 0
        local useBdr = borderClr.alpha > 0 and border > 0
        local oneFrame = frameReqs <= 1
        if not useBdr then border = 0 end

        local aHex = aChecker.rgbaPixel | 0xff000000
        local bHex = bChecker.rgbaPixel | 0xff000000
        local bkgHex = bkgClr.rgbaPixel | 0xff000000

        -- TODO: Change as new elements are added to each cell.
        local wCellTotal = cwVrf + border2
        local hCellTotal = chVrf + border2

        local spriteWidth = margin2
            + wCellTotal * cols
            + padding * colsn1
        local spriteHeight = margin2
            + hCellTotal * rows
            + padding * rowsn1
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
            gridGroup.name = "Grid"
            gridGroup.stackIndex = 1
            gridGroup.isCollapsed = true
            gridGroup.isEditable = false
        end)

        local bkgLayer = nil
        local bkgImg = Image(spriteSpec)
        bkgImg:clear(bkgHex)
        if useBkg then
            app.transaction(function()
                bkgLayer = activeSprite:newLayer()
                bkgLayer.name = "Bkg"
                bkgLayer.parent = gridGroup
                bkgLayer.opacity = opacity
                bkgLayer.isEditable = false
                bkgLayer.isContinuous = oneFrame
            end)
        end

        -- Cache methods used in loops.
        local floor = math.floor
        local strfmt = string.format
        local transact = app.transaction

        ---@type Point[]
        local bdrPoints = {}
        ---@type Layer[]
        local bdrLayers = {}

        ---@type Point[]
        local checkPoints = {}
        ---@type Layer[]
        local checkLayers = {}

        local row = -1
        while row < rowsn1 do
            row = row + 1

            local yOffset = margin + row * padding
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
                rowGroup.isCollapsed = true
                rowGroup.isEditable = false
                rowGroup.color = rowColor
            end)

            transact(function()
                local col = -1
                while col < colsn1 do
                    col = col + 1

                    local xOffset = margin + col * padding
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
                        "Cell %02d %02d",
                        1 + col, 1 + row)
                    colGroup.parent = rowGroup
                    colGroup.isCollapsed = true
                    colGroup.isEditable = false
                    colGroup.color = colColor

                    local flatIdx = col + row * cols

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
                            "Border %04d",
                            1 + flatIdx)
                        bdrLayer.parent = colGroup
                        bdrLayer.isContinuous = oneFrame
                        bdrLayer.opacity = opacity
                        bdrLayer.color = bdrColor

                        bdrPoints[1 + flatIdx] = Point(x, y)
                        bdrLayers[1 + flatIdx] = bdrLayer
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
                        "Checker %04d",
                        1 + flatIdx)
                    checkLayer.parent = colGroup
                    checkLayer.isContinuous = oneFrame
                    checkLayer.opacity = opacity
                    checkLayer.color = checkColor

                    checkPoints[1 + flatIdx] = Point(x + border, y + border)
                    checkLayers[1 + flatIdx] = checkLayer
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
                    activeSprite:newCel(bkgLayer, h, bkgImg)
                end
            end)
        end

        local i = 0
        while i < gridFlat do
            i = i + 1
            local checkPoint = checkPoints[i]
            local checkLayer = checkLayers[i]

            app.transaction(function()
                local j = 0
                while j < lenFrames do
                    j = j + 1
                    activeSprite:newCel(
                        checkLayer, j, checkImage, checkPoint)
                end
            end)

            if useBdr then
                local bdrPoint = bdrPoints[i]
                local bdrLayer = bdrLayers[i]

                app.transaction(function()
                    local j = 0
                    while j < lenFrames do
                        j = j + 1
                        activeSprite:newCel(
                            bdrLayer, j, bdrImage, bdrPoint)
                    end
                end)
            end
        end

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