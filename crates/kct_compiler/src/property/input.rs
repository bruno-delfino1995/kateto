use crate::Input;
use crate::property::{Name, Prop};

impl From<&Input> for Prop {
	fn from(val: &Input) -> Self {
		Prop::primitive(Name::Input, val.0.clone())
	}
}
