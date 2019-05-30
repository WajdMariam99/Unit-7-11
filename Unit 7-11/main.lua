display.setDefault ( "background", 53/255, 235/255, 242/255)







local physics = require( "physics" )



local playerBullets = {}







physics.start()



physics.setGravity( 0, 25 ) -- ( x, y )







local theGround = display.newImage( "assets/sprites/land.png" )



theGround.x = display.contentCenterX



theGround.y = display.contentHeight



theGround.id = "the ground"



physics.addBody( theGround, "static", { 



    friction = 0.5, 



    bounce = 0.3 



    } )







scrollSpeed = 3







local shoot = display.newImageRect( "assets/sprites/shoot1.png", 50, 50 )



shoot.x = 100



shoot.y = 250



shoot.id = "shoot button"















display.setStatusBar(display.HiddenStatusBar)



 



centerX = 180



centerY = 360







local sheetOptionsIdle =







{



    width = 232,



    height = 439,



    numFrames = 10



}







local sheetIdleNinja = graphics.newImageSheet( "assets/spriteSheets/ninjaBoyIdle.png", sheetOptionsIdle )







local sheetOptionsWalk =



{



    width = 377,



    height = 451,



    numFrames = 10



}







local sheetWalkingNinja = graphics.newImageSheet( "assets/spriteSheets/ninjaBoyThrow.png", sheetOptionsWalk )







-- sequences table



local sequence_data = {



    -- consecutive frames sequence



    {



        name = "idle",



        start = 1,



        count = 10,



        time = 300,



        loopCount = 0,



        sheet = sheetIdleninja



    },



    {



        name = "walk",



        start = 1,



        count = 10,



        time = 300,



        loopCount = 1,



        sheet = sheetWalkingNinja



    }



}







local ninja = display.newSprite( sheetIdleNinja, sequence_data )



ninja.xScale = 100/536



ninja.yScale = 92/495



ninja.x = 50



ninja.y = 400 



ninja.width = 100



ninja.height = 73



physics.addBody( ninja, "dynamic", { 



    density = 3.0, 



    friction = 0.5, 



    bounce = 0.3 



    } )







ninja:play()







-- After a short time, swap the sequence to 'seq2' which uses the second image sheet



local function shootTouch ( event )   



    ninja:setSequence( "walk" )



    ninja:play()



    print("Knife Thrown")







    if ( event.phase == "began" ) then



        -- make a bullet appear



        local aSingleBullet = display.newImageRect( "assets/sprites/bullet.png", 50, 25 )



        aSingleBullet.x = ninja.x + 50



        aSingleBullet.y = ninja.y



        physics.addBody( aSingleBullet, 'dynamic' )



        -- Make the object a "bullet" type object



        aSingleBullet.isBullet = true



        aSingleBullet.isFixedRotation = true



        aSingleBullet.gravityScale = 0



        aSingleBullet.id = "bullet"



        aSingleBullet:setLinearVelocity( 1000, 0 )







        table.insert(playerBullets,aSingleBullet)



        print("# of bullet: " .. tostring(#playerBullets))



    end







    return true



end







timer.performWithDelay( 2000, swapSheet )















local function checkPlayerBulletsOutOfBounds()



    -- check if any bullets have gone off the screen



    local bulletCounter







    if #playerBullets > 0 then



        for bulletCounter = #playerBullets, 1 , -1 do



            if playerBullets[bulletCounter].x > display.contentWidth + 1000 then



                playerBullets[bulletCounter]:removeSelf()



                playerBullets[bulletCounter] = nil



                table.remove(playerBullets, bulletCounter)



                print("remove bullet")



            end



        end



    end



end











--Second Ninja











display.setStatusBar(display.HiddenStatusBar)



 



centerX = 180



centerY = 360







local sheetOptionsIdle =







{



    width = 232,



    height = 439,



    numFrames = 10



}







local sheetIdleNinja = graphics.newImageSheet( "assets/spriteSheets/ninjaBoyIdle.png", sheetOptionsIdle )







local sheetOptionsWalk =



{



    width = 482,



    height = 498,



    numFrames = 10



}







local sheetWalkingNinja = graphics.newImageSheet( "assets/spriteSheets/ninjaBoyDead.png", sheetOptionsWalk )







-- sequences table



local sequence_data = {



    -- consecutive frames sequence



    {



        name = "idle",



        start = 1,



        count = 10,



        time = 800,



        loopCount = 1,



        sheet = sheetIdleninja



    },



    {



        name = "dead",



        start = 1,



        count = 10,



        time = 300,



        loopCount = 1,



        sheet = sheetWalkingNinja



    }



}







local ninja2 = display.newSprite( sheetIdleNinja, sequence_data )



ninja2.xScale = 100/536



ninja2.yScale = 92/495



ninja2.x = 240



ninja2.y = 400 



ninja2.width = 100



ninja2.height = 73



ninja2.id = "ninja 2"



physics.addBody( ninja2, "dynamic", { 



    density = 3.0, 



    friction = 0.5, 



    bounce = 0.3 



    } )







local function onCollision( event )



 



    if ( event.phase == "began" ) then



 



        local obj1 = event.object1



        local obj2 = event.object2



        local whereCollisonOccurredX = obj1.x



        local whereCollisonOccurredY = obj1.y







        if ( ( obj1.id == "ninja 2" and obj2.id == "bullet" ) or



             ( obj1.id == "bullet" and obj2.id == "ninja 2" ) ) then



            -- Remove both the laser and asteroid



            display.remove( "bullet" )



            



            -- remove the bullet



            local bulletCounter = nil



            



            for bulletCounter = #playerBullets, 1, -1 do



                if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then



                    playerBullets[bulletCounter]:removeSelf()



                    playerBullets[bulletCounter] = nil



                    table.remove( playerBullets, bulletCounter )



                    break



                end



            end











            -- Increase score



            score = 1



            print ("Eliminations:", score)







            ninja2:setSequence( "dead" )



            ninja2:play()



            print("Kill Confirmed")



        end



    end



end







ninja2:play()







Runtime:addEventListener( "collision", onCollision )



Runtime:addEventListener( "enterFrame", checkPlayerBulletsOutOfBounds )



shoot:addEventListener( "touch", shootTouch )
