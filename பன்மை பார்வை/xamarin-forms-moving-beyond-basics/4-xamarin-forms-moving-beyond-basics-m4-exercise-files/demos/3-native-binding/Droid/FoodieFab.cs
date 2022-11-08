﻿using System;
using Android.Support.Design.Widget;
using Android.Content;
using Xamarin.Forms;

namespace Foodie.Droid
{
	public class FoodieFab : FloatingActionButton
	{
		public Command Command { get; set; }

		public FoodieFab(Context context) : base(context)
		{
			this.SetImageResource(Resource.Drawable.ic_add_white_24dp);

			Click += (sender, e) =>
			{
				Command?.Execute(null);
			};
		}
	}
}
