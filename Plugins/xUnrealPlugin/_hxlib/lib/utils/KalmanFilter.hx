package lib.utils;

@:structInit
class KFloat 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var f                             : KalmanFilter;
	public var last					 	        : Float				= 0.0;
  public var value	(default, set) 	: Float				= 0.0;

	public function new(?processNoise:Float=0.01,?measurementNoise:Float=2.0,?stateVector:Float=1.1,?controlVector:Float=1.0, ?measurementVector:Float=2.0,?control:Float=0.3)
	{
	  f = new KalmanFilter(processNoise,measurementNoise,stateVector,controlVector,measurementVector,control);
	}
	
 	function set_value(v:Float):Float
	{
	  last = f.filter(v);
		return value=last;    
	}
	
	public function add(val:Float):Float
	{
		return value = val;
	}

  
  public function setMeasurementNoise(noise:Float)
  {
    f.Q = noise;
  }

  /**
  * Set the process noise R
  * @param {Number} noise
  */
  public function setProcessNoise(noise:Float)
  {
    f.R = noise;
  }

	public function dispose()
	{
		f = null;	
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function create(?stateVector:Float=1.1):KFloat 
	{
    return new KFloat(stateVector);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

@:structInit
class KFloat2
{
	/////////////////////////////////////////////////////////////////////////////////////

	var fx                            : KalmanFilter;
	var fy                            : KalmanFilter;
	public var lastX				 	        : Float				= 0.0;
	public var lastY				 	        : Float				= 0.0;
  public var x (default, set) 	    : Float				= 0.0;
  public var y (default, set) 	    : Float				= 0.0;

	public function new(?processNoise:Float=0.01,?measurementNoise:Float=2.0,?stateVector:Float=1.1,?controlVector:Float=1.0, ?measurementVector:Float=2.0,?control:Float=0.3)
	{
	  fx = new KalmanFilter(processNoise,measurementNoise,stateVector,controlVector,measurementVector,control);
	  fy = new KalmanFilter(processNoise,measurementNoise,stateVector,controlVector,measurementVector,control);
	}
	
 	function set_x(v:Float):Float
	{
	  lastX = fx.filter(v);
		return x=lastX;    
	}
	
 	function set_y(v:Float):Float
	{
	  lastY = fy.filter(v);
		return y=lastY;    
	}
	
	public function addX(val:Float):Float
	{
		return x = val;
	}
  
	public function addY(val:Float):Float
	{
		return y = val;
	}
  
  
	public function predictX(?control:Null<Float>):Float
	{
    if (control==null)
      control = fx.u;

    return fx.predict(control);
	}
  
	public function predictY(?control:Null<Float>):Float
	{
    if (control==null)
      control = fy.u;

    return fy.predict(control);
	}
  
  public function setMeasurementNoise(noise:Float)
  {
    fx.Q = noise;
    fy.Q = noise;
  }

  /**
  * Set the process noise R
  * @param {Number} noise
  */
  public function setProcessNoise(noise:Float)
  {
    fx.R = noise;
    fy.R = noise;
  }

	public function dispose()
	{
		fx = null;	
		fy = null;	
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function create(?stateVector:Float=1.1):KFloat2 
	{
    return new KFloat2(stateVector);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

class KalmanFilter
{
  /////////////////////////////////////////////////////////////////////////////////////

    public var R      : Float;           // 0.1 - 1.0 noise power desirable
    public var Q      : Float;            // 0-100 noise power estimated

    public var A      : Float;          // 0.0-6.0 (State vector)
    public var B      : Float;          // 0.0-100.0 (Control vector)
    public var C      : Float;          // 0.0-6.0(Measurement vector)
    public var cov    : Null<Float>;
    public var x      : Null<Float>;    // estimated signal without noise
    public var u      : Float;          // 0.0-50.0 control

  /////////////////////////////////////////////////////////////////////////////////////

  /**
  * Create 1-dimensional kalman filter
  * @param  {Float} options.R Process noise
  * @param  {Float} options.Q  0-100 Measurement noise
  * @param  {Float} options.A State vector
  * @param  {Float} options.B Control vector
  * @param  {Float} options.C Measurement vector
  * @return {KalmanFilter}
  */  
  /////////////////////////////////////////////////////////////////////////////////////

  public function new(R:Float=1,Q:Float=1,A:Float=1,B:Float=0, C:Float=1,u:Float=0.3)
  {
    this.R = R; // noise power desirable
    this.Q = Q; // noise power estimated
    this.A = A;
    this.C = C;
    this.B = B;
  }

  /**
  * Filter a new value
  * @param  {Float} z Measurement
  * @param  {Float} u Control
  * @return {Float}
  */
  public function filter(measurement:Float, ?control:Null<Float>)
  {
    if (control==null)
      control = u;

    if (x==null)
    {
      x = (1 / C) * measurement;
      cov = (1 / C) * Q * (1 / C);
    }
    else
    {
      // Compute prediction
      final predX = predict(control);
      final predCov = uncertainty();

      // Kalman gain
      final K = predCov * C * (1 / ((C * predCov * C) + Q));

      // Correction
      x = predX + K * (measurement - (C * predX));
      cov = predCov - (K * C * predCov);
    }

    return x;
  }

  /**
  * Predict next value
  * @param  {Float} [u] Control
  * @return {Float}
  */
  public function predict(control:Float=0.0)
  {
    return (A * x) + (B * control);
  }
  
  /**
  * Return uncertainty of filter
  * @return {Float}
  */
  public function uncertainty()
  {
    return ((A * cov) * A) + R;
  }
  
  /**
  * Return the last filtered measurement
  * @return {Number}
  */
  public function lastMeasurement()
  {
    return x;
  }

  /**
  * Set measurement noise Q
  * @param {Number} noise
  */
  public function setMeasurementNoise(noise)
  {
    Q = noise;
  }

  /**
  * Set the process noise R
  * @param {Number} noise
  */
  public function setProcessNoise(noise)
  {
    R = noise;
  }  

}
