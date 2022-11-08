using System;
using System.Collections.Generic;
namespace Foodie
{
	// Generic version of the "list of lists"
	// This can be used across projects as T can be anything and bound however you'd like
	// To go a step further - the Title and ShortName could be removed and this could
	// be defined as ListViewGrouping<T, K> with K being a property used to bind
	// title/section properties
	public class ListViewGrouping<T> : List<T>
	{
		public string Title
		{
			get;
			set;
		}

		public string ShortName
		{
			get;
			set;
		}

		public ListViewGrouping(string title, string shortName)
		{
			Title = title;
			ShortName = shortName;
		}
	}
}
