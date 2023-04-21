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
    layerColorBlue = 128,
    frames = 1,
    fps = 12,
    layerColorAlpha = 96
}

local dlg = Dialog { title = "Grid Template" }

dlg:slider {
    id = "cols",
    label = "Cells:",
    -- label = "Columns:",
    min = 1,
    max = 32,
    value = defaults.cols
}

dlg:slider {
    id = "rows",
    -- label = "Rows:",
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

        local layerColorBlue = defaults.layerColorBlue
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

        local aHex = aChecker.rgbaPixel | 0xff000000
        local bHex = bChecker.rgbaPixel | 0xff000000
        local bkgHex = bkgClr.rgbaPixel | 0xff000000
        local bdrHex = borderClr.rgbaPixel | 0xff000000

        local spriteWidth = margin2
            + cwVrf * cols
            + border2 * cols
            + padding * colsn1
        local spriteHeight = margin2
            + chVrf * rows
            + border2 * rows
            + padding * rowsn1
        local activeSprite = Sprite(spriteWidth, spriteHeight)
        local activeLayer = activeSprite.layers[1]
        app.command.LoadPalette { preset = "default" }

        local spriteSpec = activeSprite.spec
        local cellSpec = ImageSpec(spriteSpec)
        cellSpec.width = cwVrf
        cellSpec.height = chVrf
        local cellImage = Image(cellSpec)

        if wCheck > 0 and hCheck > 0 and aHex ~= bHex then
            local pxItr = cellImage:pixels()
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
            cellImage:clear(aHex)
        end

        if useBdr then
            -- TODO: Baking the border into the
            -- image messes with the auto guiding.
            -- Maybe make each column a group,
            -- then offset?
            local bdrSpec = ImageSpec(spriteSpec)
            bdrSpec.width = cwVrf + border2
            bdrSpec.height = chVrf + border2
            local bdrImage = Image(bdrSpec)

            bdrImage:clear(bdrHex)
            bdrImage:drawImage(cellImage,
                Point(border, border))

            cellImage = bdrImage
            cwVrf = bdrSpec.width
            chVrf = bdrSpec.height
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
        local points = {}

        ---@type Layer[]
        local layers = {}

        local row = -1
        while row < rowsn1 do
            row = row + 1

            local yOffset = margin + row * padding
            local y = row * chVrf + yOffset
            local green = floor(row * rowToGreen + 0.5)

            local rowGroup = nil
            local rowName = strfmt("Row %02d", row + 1)
            transact(function()
                rowGroup = activeSprite:newGroup()
                rowGroup.name = rowName
                rowGroup.parent = gridGroup
                rowGroup.isCollapsed = true
                rowGroup.isEditable = false

                local col = -1
                while col < colsn1 do
                    col = col + 1

                    local xOffset = margin + col * padding
                    local x = col * cwVrf + xOffset
                    local red = floor(col * colToRed + 0.5)

                    local colColor = Color {
                        r = red,
                        g = green,
                        b = layerColorBlue,
                        a = layerColorAlpha
                    }

                    local colLayer = nil
                    colLayer = activeSprite:newLayer()
                    colLayer.name = strfmt("[%02d, %02d]", col + 1, row + 1)
                    colLayer.parent = rowGroup
                    colLayer.color = colColor
                    colLayer.opacity = opacity
                    colLayer.isEditable = false
                    colLayer.isContinuous = oneFrame

                    local flatIdx = col + row * cols
                    points[1 + flatIdx] = Point(x, y)
                    layers[1 + flatIdx] = colLayer
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
            local point = points[i]
            local layer = layers[i]

            app.transaction(function()
                local j = 0
                while j < lenFrames do
                    j = j + 1
                    activeSprite:newCel(
                        layer, j, cellImage, point)
                end
            end)
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