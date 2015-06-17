@variables = qw(
cyl  disp hp   drat wt   qsec vs   am   gear carb
);

sub combine_all {
    @acum = ();
    @models = ();

    foreach my $var(@variables) {
        push(@acum, $var);
        $ac_var = join " + ", map {$_} @acum;
        $model_name = "fit_$var";
        print "$model_name <- lm(mpg ~ $ac_var, data=mtcars)\n";
        push(@models, $model_name);
    }  


    print "anova("; 
    print join ",", map {$_} @models; 
    print ")\n";
}

sub par_with_am {

    foreach my $var(@variables) {
        $model_name = "fit_$var";
        $model_name2 = "fit2_$var";
        print "$model_name <- lm(mpg ~ $var, data=mtcars)\n";
        print "$model_name2 <- lm(mpg ~ $var + am, data=mtcars)\n";
        print "anova($model_name, $model_name2)\n";
    }  
}

#combine_all();
par_with_am();