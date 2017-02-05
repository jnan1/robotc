/**********************************************
 * Lab 3 : Starter code
 * Written by Kaushik Viswanathan,
 * Modified by Allan Wang (Jan 2017)

 * Feel free to modify any part of these codes.
 **********************************************/

//Global variables - you will need to change some of these
//Robot's positions
float robot_X = 0.0, robot_Y = 0.0, robot_TH = 0.0;
float wheelradius = 1.1;
float robotWidth = 4.80315;

int velocityUpdateInterval = 5;
int PIDUpdateInterval = 2;

//Change these during demo
int inputStraight[2] = {36*1.414, 12}; // in mm
int inputTurn[2] = {45, -45}; // in degrees, negative means clockwise rotation
int motorPower = 50;

/*****************************************
 * Complete this function so that it
 * continuously updates the robot's position
 *****************************************/
task dead_reckoning()
{

	while(1)
	{
		//
		// Fill in code for numerical integration / position estimation here
		//

		/*Code that plots the robot's current position and also prints it out as text*/
		nxtSetPixel(50 + (int)(100.0 * robot_X), 32 + (int)(100.0 * robot_Y));
		nxtDisplayTextLine(0, "X: %f", robot_X);
		nxtDisplayTextLine(1, "Y: %f", robot_Y);
		nxtDisplayTextLine(2, "th: %f", robot_TH);

		wait1Msec(velocityUpdateInterval);
	}
}

/*****************************************
 * Function that draws a grid on the LCD
 * for easier readout of whatever is plot
 *****************************************/
void draw_grid()
{
	for(int i = 0; i < 65; i++)
	{
		nxtSetPixel(50, i);
		int grid5 = (i - 32) % 5;
		int grid10 = (i - 32) % 10;
		if(!grid5 && grid10)
		{
			for(int j = -2; j < 3; j++)
			{
				nxtSetPixel(50 + j, i);
			}
		}
		else if(!grid10)
		{
			for(int j = -4; j < 5; j++)
			{
				nxtSetPixel(50 + j, i);
			}
		}
	}
	for(int i = 0; i < 101; i++)
	{
		nxtSetPixel(i, 32);
		int grid5 = (i - 100) % 5;
		int grid10 = (i - 100) % 10;
		if(!grid5 && grid10)
		{
			for(int j = -2; j < 3; j++)
			{
				nxtSetPixel(i, 32 + j);
			}
		}
		else if(!grid10)
		{
			for(int j = -4; j < 5; j++)
			{
				nxtSetPixel(i, 32 + j);
			}
		}
	}
}

/**********************************************
 * Function that judges if two floats are equal
 **********************************************/
 bool equal(float a, float b, float epsilon) {
   if (abs(a-b) < epsilon) {
     return true;
   } else {
     return false;
   }
 }


/*****************************************
 * Main function - Needs changing
 *****************************************/
task main()
{
	/* Reset encoders and turn on PID control */
	nMotorEncoder[motorB] = 0;
	nMotorEncoder[motorA] = 0;
	nMotorPIDSpeedCtrl[motorB] = mtrSpeedReg;
	nMotorPIDSpeedCtrl[motorA] = mtrSpeedReg;
	nPidUpdateInterval = PIDUpdateInterval;

	int goalStraight = 0;
	int goalTurn = 0;
	float start_X = 0;
	float start_Y = 0;
	float start_TH = 0;


	draw_grid();
	startTask(dead_reckoning);

	clearTimer(T1);
	float prevt = (float)time1[T1]/1000;
	for(int i = 0; i < 2; i++)
	{
		float distTravelled = 0;
		float angleTurned = 0;
		goalStraight = inputStraight[i];
		goalTurn = inputTurn[i];

		start_X = robot_X;
		start_Y = robot_Y;
		start_TH = robot_TH;

		nMotorEncoder[motorB] = 0;
		nMotorEncoder[motorA] = 0;
		//turning
		while (!equal(angleTurned, goalTurn, 1)) {
			int sgn = goalTurn > 0 ? 1 : -1;
			motor[motorA] = motorPower / 3 * (-sgn);
			motor[motorB] = motorPower / 3 * sgn;
			angleTurned = nMotorEncoder[motorB] * wheelradius / robotWidth * 2;
			nxtDisplayTextLine(3, "sgn: %d", sgn);
		}
		motor[motorA] = 0;
		motor[motorB] = 0;
		wait1Msec(1000);
		//moving in a straight line
		nMotorEncoder[motorB] = 0;
		nMotorEncoder[motorA] = 0;
		float l = nMotorEncoder[motorA] * wheelradius * PI / 180;
		float r = nMotorEncoder[motorB] * wheelradius * PI / 180;
		while (!equal(distTravelled, goalStraight, 1)) {
			motor[motorA] = motorPower;
			motor[motorB] = motorPower;
			l = (float)nMotorEncoder[motorA] * wheelradius * PI / 180;
			r = (float)nMotorEncoder[motorB] * wheelradius * PI / 180;
			distTravelled = (l+r)/2;
			wait1Msec(100);
		}
		motor[motorA] = 0;
		motor[motorB] = 0;

		wait1Msec(100 * 5);
	}
	motor[motorA] = 0;
	motor[motorB] = 0;
	nNxtButtonTask  = 0;
	while(nNxtButtonPressed != kExitButton) {}
}
