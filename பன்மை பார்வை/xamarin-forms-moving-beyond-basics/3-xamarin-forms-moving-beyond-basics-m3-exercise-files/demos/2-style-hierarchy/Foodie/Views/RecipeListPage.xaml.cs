using System;
using System.Collections.Generic;

using Xamarin.Forms;

namespace Foodie
{
	public partial class RecipeListPage : ContentPage
	{
		public RecipeListPage()
		{
			InitializeComponent();
		}

		async void Handle_ItemSelected(object sender, Xamarin.Forms.SelectedItemChangedEventArgs e)
		{
			if (e.SelectedItem != null)
			{
				var recipe = e.SelectedItem as Recipe;
				if (recipe == null)
					return;

				var detailPage = new RecipeDetailPage(recipe);
				await Navigation.PushAsync(detailPage);

				recipeList.SelectedItem = null;
			}
		}
	}
}
