use clap::ArgMatches;
use clap::{App, Arg, SubCommand};
use kct_package::Package;
use std::error::Error;
use std::path::PathBuf;

pub fn command() -> App<'static, 'static> {
	SubCommand::with_name("package")
		.about("package a KCP into a KCP Archive")
		.arg(
			Arg::with_name("package")
				.help("Directory containing the KCP")
				.index(1)
				.required(true),
		)
}

// TODO: Can't we use Box<dyn Display> for error since all our errors implement
// Display?
pub fn run(matches: &ArgMatches) -> Result<String, Box<dyn Error>> {
	let package_from: PathBuf = matches.value_of("package").map(PathBuf::from).unwrap();
	let package = Package::from_path(package_from)?;

	let cwd = std::env::current_dir()?;
	let compressed_path = package.archive(&cwd)?;

	Ok(format!(
		"Successfully packaged KCP and saved it to: {}",
		compressed_path.to_str().unwrap()
	))
}
