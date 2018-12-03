<form class="form-row d-flex w-100" action="{router page='search'}{$searchType|default:'topics'}">
    <div class="col-12 col-sm-10 col-md-10 col-lg-9 col-xl-8">
        <input class="form-control mr-1 " type="search" placeholder="{$aLang.search.search}" aria-label="Search">
    </div>
    <div class="col-12 col-sm-2 col-md-2  col-lg-3 col-xl-4 d-flex justify-content-end">
        <button class="btn btn-outline-success mt-1 mt-sm-0" type="submit">{$aLang.search.search}</button>
    </div>
</form>