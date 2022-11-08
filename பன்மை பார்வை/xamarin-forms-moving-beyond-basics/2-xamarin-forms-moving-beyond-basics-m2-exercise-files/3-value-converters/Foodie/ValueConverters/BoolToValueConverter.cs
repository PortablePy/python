using System;
using System.Globalization;
using Xamarin.Forms;
namespace Foodie
{
	// This is the generic value converter an can be used to return any type 
	// based off of a boolean. You need to set the TrueValue and FalseValue
	// before using the converter.
	// It also has the ability to convert back to a boolean based on the T changing in the view.
	public class BoolToValueConverter<T> : IValueConverter
	{
		public T TrueValue { get; set; }
		public T FalseValue { get; set; }

		public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
		{
			if (value.GetType() != typeof(bool))
				return FalseValue;

			return (bool)value ? TrueValue : FalseValue;
		}

		public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
		{
			if (value.GetType() != typeof(T))
				return false;

			return ((T)value).Equals(TrueValue);
		}
	}
}
