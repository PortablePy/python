using System;
using System.Globalization;
using Xamarin.Forms;

namespace Foodie
{
	// This value converter works ... HOWEVER ... none of the images are included in this demo project
	// due to licensing. To see it in action, add some images to the Images folder, set the build action
	// to embedded resource and update the RecipeData to have Recipes return the name (include file extension)
	// of the image
	public class RecipeToImageValueConverter : IValueConverter
	{
		public string Assembly { get; set; }

		public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
		{
			var source = value as string;
			if (string.IsNullOrEmpty(source))
				return null;

			var imagePath = $"{Assembly}.{source}";

			return ImageSource.FromResource(imagePath);
		}

		public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
		{
			throw new NotImplementedException();
		}

	}
}
   