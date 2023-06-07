public final class CLIKommander: CLICommand {
	/** Creates a CLIKommander instance with an
		app name as `default`. If the app name 
		requires to be modified, please refer to
		the `setAppName` method */
	public init () {
		super.init("default")
	}
	
	public func setAppName (_ name: String) -> Void {
		self.name = name;
	}
}