-----------------------------------------------------------------------------------------

--

-- Created By: Wajd Mariam

-- Created On: May 25th, 2019

-----------------------------------------------------------------------------------------

display.setStatusBar (display.HiddenStatusBar)



display.setDefault ( "background", 53/255, 235/255, 242/255)

-- phyiscs section

local physics = require ("physics")



physics.start()

physics.setGravity ( 0, 25 )





scrollSpeed = 3





local theGround = display.newImage ("assets/sprites/land.png")

theGround.x = display.contentCenterX

theGround.y = 450

theGround.id = "The Ground"

physics.addBody( theGround, "static", {

    friction =  0.5,

    bounce = 0.3



     })





local shoot = display.newImageRect("assets/sprites/shoot1.png", 50, 50)

shoot.x = 100

shoot.y = 200

shoot.id = "Shoot Button"





-- Ninja Sprite Sheet

display.setStatusBar(display.HiddenStatusBar)



centerX = 120

centerY = 360 



local sheetOptionsIdle =  



{

	width = 232, 

	height = 439,

	numFrames = 10,

}



local sheetIdleNinja = graphics.newImageSheet("assets/spriteSheets/ninjaBoyIdle.png", sheetOptionsIdle)





local sheetOptionsThrow = 



{

    width = 375,

    height = 451,

    numFrames = 10

}



local sheetThrowingNinja = graphics.newImageSheet("assets/spriteSheets/ninjaBoyThrow.png", sheetOptionsThrow)



-- sequences table

local sequence_table = {

    

    {

    name = "idle",

    start = 1,

    count = 10,

    time = 300,

    loopCount = 0, 

    sheet = sheetIdleNinja

    },



    {

    name = "throw",

    start = 1,

    count = 10, 

    time = 300,

    loopCount = 1,

    sheet = sheetThrowingNinja

    }



}



local Ninja = display.newSprite ( sheetIdleNinja, sequence_table )

Ninja.xScale = 100/536

Ninja.yScale = 100/495

Ninja.x = 50

Ninja.y = 400

Ninja.width = 150

Ninja.height = 80

physics.addBody ( Ninja, "dynamic", { 



	density = 2.5,

	friction = 0.5,

	bounce = 0.3

    } ) 

    



Ninja:play()





local function shootTouch( event )



	Ninja:setSequence ( "walk" )

	Ninja:play()

	print ("Knife Thrown")



    if ( event.phase == "began") then



    	local SingleBullet = display.newImageRect ("assets/sprites/bullet.png", 25, 25)

    	SingleBullet.x = Ninja.x + 50

    	SingleBullet.y = Ninja.y

    	physics.addBody ( SingleBullet, "dynamic")



    	SingleBullet.isBullet = true

    	SingleBullet.isFixedRotation = true

    	SingleBullet.gravityScale = 0

    	SingleBullet.id = "Bullet"

    	SingleBullet:setLinearVelocity( 1000,0 )



    	-- table.insert( playerBullets ,SingleBullet)

        -- print ("#of bullet:" .. tostring (#playerBullets))



    end



    return true





end 





timer.performWithDelay( 2000, swapSheet )





local function checkPlayerBulletsOutOfBounds()



     local bulletCounter 



     if #playerBullets > 0 then



     	for bulletCounter = #playerBullets, 1, -1  do

     		if playerBullets[bulletCounter].x > display.contentWidth + 1000 then 

     			playerBullets[bulletCounter]  = nil

     			table.remove(playerBullets, bulletCounter)

     			print("remove bullet")



             end

    

        end



    end



end 



display.setStatusBar(display.HiddenStatusBar)



centerX = 200

centerY = 360

 

local sheetOptionsIdle =  



{

	width = 232,

	height = 439,

	numFrames = 10,

}



local sheetIdleNinja2 = graphics.newImageSheet("assets/spriteSheets/ninjaBoyIdle.png", sheetOptionsIdle)





local sheetOptionsDie = 

{

	width = 482,

	height = 498,

	numFrames = 10

}



local sheetDeadNinja2 = graphics.newImageSheet ("assets/spriteSheets/ninjaBoyDead.png", sheetOptionsDie)



local sequence_table = 

 

    {

     name = "Idle",

     start = 1,

     count = 10,

     time = 300,

     loopCount = 0,

     sheet = sheetOptionsIdle



     },

     {

     name = "die",

     start = 1,

     count = 10,

     time = 300,

     loopCount = 1,

     sheet = sheetOptionsDie

     }



 -- }







local Ninja2 = display.newSprite (sheetIdleNinja2, sequence_table)



Ninja2.xScale = 100/536

Ninja2.xScale = 100/495

Ninja2.x = 350

Ninja2.y = 350

Ninja2.height = 180

Ninja2.width = 90

physics.addBody ( Ninja2, "dynamic", { 



	density = 3.5,

	friction = 0.5, 

	bounce = 0.3

	    } )



local function Collision (event)
	if (event.phase == "began") then
		local obj1 = event.obj1
		local obj2 = event.obj2 
		local WhereCollisionOccuredX = obj1.x
		local WhereCollisionOccuredY = obj1.y


		if ((obj1.id == "Ninja2" and obj2.id == "Bullet" ) or

			(obj1.id == "Bullet" and obj2.id == "Ninja2" )) then

		display.remove ( "bullet" )


		local bulletCounter = nil

		for bulletCounter = #playerBullets, 1 ,-1 do

  			if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then
                    playerBullets[bulletCounter]:removeSelf()
                    playerBullets[bulletCounter] = nil
                    table.remove( playerBullets, bulletCounter )

                    break
                end
            end


            score = 1
            print ("Eliminations:", score)
            ninja2:setSequence( "dead" )
            ninja2:play()
            print("Kill Confirmed")

        end

    end

end

Ninja2:play()

Runtime:addEventListener ("Collision", Collision)

Runtime:addEventListener ("enterFrame", checkPlayerBulletsOutOfBounds)

shoot:addEventListener ("touch", shootTouch)
