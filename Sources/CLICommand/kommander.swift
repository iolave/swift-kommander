public final class CLIKommander: CLICommand {
	public init () {
		super.init("default")
	}
	
	public func setAppName (_ name: String) -> Void {
		self.name = name;
	}
}