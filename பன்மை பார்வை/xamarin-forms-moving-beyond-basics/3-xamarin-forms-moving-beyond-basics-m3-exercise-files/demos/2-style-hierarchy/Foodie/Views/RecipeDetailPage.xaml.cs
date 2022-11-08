using System;
using System.Collections.Generic;

using Xamarin.Forms;

namespace Foodie
{
	public partial class RecipeDetailPage : ContentPage
	{
		public RecipeDetailPage(Recipe theRecipe)
		{
			InitializeComponent();

			BindingContext = theRecipe;
		}
	}
}
