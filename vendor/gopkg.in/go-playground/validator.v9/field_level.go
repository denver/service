package validator

import "reflect"

// FieldLevel contains all the information and helper functions
// to validate a field
type FieldLevel interface {
<<<<<<< HEAD

=======
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
	// returns the top level struct, if any
	Top() reflect.Value

	// returns the current fields parent struct, if any or
	// the comparison value if called 'VarWithValue'
	Parent() reflect.Value

	// returns current field for validation
	Field() reflect.Value

	// returns the field's name with the tag
	// name taking precedence over the fields actual name.
	FieldName() string

	// returns the struct field's name
	StructFieldName() string

	// returns param for validation against current field
	Param() string

<<<<<<< HEAD
=======
	// GetTag returns the current validations tag name
	GetTag() string

>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
	// ExtractType gets the actual underlying type of field value.
	// It will dive into pointers, customTypes and return you the
	// underlying value and it's kind.
	ExtractType(field reflect.Value) (value reflect.Value, kind reflect.Kind, nullable bool)

	// traverses the parent struct to retrieve a specific field denoted by the provided namespace
	// in the param and returns the field, field kind and whether is was successful in retrieving
	// the field at all.
	//
	// NOTE: when not successful ok will be false, this can happen when a nested struct is nil and so the field
	// could not be retrieved because it didn't exist.
<<<<<<< HEAD
	GetStructFieldOK() (reflect.Value, reflect.Kind, bool)
=======
	//
	// Deprecated: Use GetStructFieldOK2() instead which also return if the value is nullable.
	GetStructFieldOK() (reflect.Value, reflect.Kind, bool)

	// GetStructFieldOKAdvanced is the same as GetStructFieldOK except that it accepts the parent struct to start looking for
	// the field and namespace allowing more extensibility for validators.
	//
	// Deprecated: Use GetStructFieldOKAdvanced2() instead which also return if the value is nullable.
	GetStructFieldOKAdvanced(val reflect.Value, namespace string) (reflect.Value, reflect.Kind, bool)

	// traverses the parent struct to retrieve a specific field denoted by the provided namespace
	// in the param and returns the field, field kind, if it's a nullable type and whether is was successful in retrieving
	// the field at all.
	//
	// NOTE: when not successful ok will be false, this can happen when a nested struct is nil and so the field
	// could not be retrieved because it didn't exist.
	GetStructFieldOK2() (reflect.Value, reflect.Kind, bool, bool)

	// GetStructFieldOKAdvanced is the same as GetStructFieldOK except that it accepts the parent struct to start looking for
	// the field and namespace allowing more extensibility for validators.
	GetStructFieldOKAdvanced2(val reflect.Value, namespace string) (reflect.Value, reflect.Kind, bool, bool)
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
}

var _ FieldLevel = new(validate)

// Field returns current field for validation
func (v *validate) Field() reflect.Value {
	return v.flField
}

// FieldName returns the field's name with the tag
<<<<<<< HEAD
// name takeing precedence over the fields actual name.
=======
// name taking precedence over the fields actual name.
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
func (v *validate) FieldName() string {
	return v.cf.altName
}

<<<<<<< HEAD
=======
// GetTag returns the current validations tag name
func (v *validate) GetTag() string {
	return v.ct.tag
}

>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
// StructFieldName returns the struct field's name
func (v *validate) StructFieldName() string {
	return v.cf.name
}

// Param returns param for validation against current field
func (v *validate) Param() string {
	return v.ct.param
}

// GetStructFieldOK returns Param returns param for validation against current field
<<<<<<< HEAD
func (v *validate) GetStructFieldOK() (reflect.Value, reflect.Kind, bool) {
	return v.getStructFieldOKInternal(v.slflParent, v.ct.param)
}
=======
//
// Deprecated: Use GetStructFieldOK2() instead which also return if the value is nullable.
func (v *validate) GetStructFieldOK() (reflect.Value, reflect.Kind, bool) {
	current, kind, _, found := v.getStructFieldOKInternal(v.slflParent, v.ct.param)
	return current, kind, found
}

// GetStructFieldOKAdvanced is the same as GetStructFieldOK except that it accepts the parent struct to start looking for
// the field and namespace allowing more extensibility for validators.
//
// Deprecated: Use GetStructFieldOKAdvanced2() instead which also return if the value is nullable.
func (v *validate) GetStructFieldOKAdvanced(val reflect.Value, namespace string) (reflect.Value, reflect.Kind, bool) {
	current, kind, _, found := v.GetStructFieldOKAdvanced2(val, namespace)
	return current, kind, found
}

// GetStructFieldOK returns Param returns param for validation against current field
func (v *validate) GetStructFieldOK2() (reflect.Value, reflect.Kind, bool, bool) {
	return v.getStructFieldOKInternal(v.slflParent, v.ct.param)
}

// GetStructFieldOKAdvanced is the same as GetStructFieldOK except that it accepts the parent struct to start looking for
// the field and namespace allowing more extensibility for validators.
func (v *validate) GetStructFieldOKAdvanced2(val reflect.Value, namespace string) (reflect.Value, reflect.Kind, bool, bool) {
	return v.getStructFieldOKInternal(val, namespace)
}
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
