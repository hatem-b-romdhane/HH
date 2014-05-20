<script type="text/javascript">
    $(document).ready(function () {
        (function() {

            var upload   = document.getElementById('upload');   // form input
                    duration = document.getElementById('duration'); // output for user
            var submitboutton = document.getElementById('Submitvideo');
            var duree = document.getElementById('duree');
            // add a change event listener to the form input
            upload.addEventListener('change', function(e) {

                var file,
                        reader;

                // check that a file has been selected
                if (this.files.length !== 1) {
                    return;
                }

                duration.innerText = 'reading video...';
                file = this.files[0];

                // check the file's mime type, we want mp4 in this example
                if (file.type !== 'video/mp4') {
                    duration.innerText = 'expected video/mp4, got ' + file.type;
                    return false;
                }

                // create a FileReader object
                // and read the file as a data/url
                // string so we can inline it later
                reader = new FileReader();
                reader.readAsDataURL(file);

                // callback when the reader is complete
                reader.onload = function() {

                    var video,
                            timeout;

                    duration.innerText = 'processing video...';

                    // create a html <video> element
                    // assign data/url as src
                    video = document.createElement('video');
                    video.src = this.result;

                    // poll the video readyState until it's ready
                    // this came from another SO answer (which I accidentally closed... sorry/thanks :s )
                    // we should now have our video duration, so echo to the browser!
                    timeout = setInterval(function(){
                        if (video.readyState > 0) {
                            duree.value = video.duration;
                            if(video.duration > 30)
                            {
                                submitboutton.hidden =true;
                                duration.innerText = 'La video ne doit pas dépasser les 30 secondes.';
                            }
                            else{
                                submitboutton.hidden =false;
                                duration.innerText = 'video is ' + video.duration + ' seconds';
                            }
                            clearInterval(timeout);
                        }
                    }, 500);

                };

            }, false);

            var package   = document.getElementById('package');
            var prix   = document.getElementById('prix');
            package.addEventListener('change', function(e) {
                alert($( "#package" ).val());
                prix.innerText = 'Prix : ' + $( "#package" ).val()*0.5;

            }, false);
        })();
        });
</script>
{include file="$tpl_dir./errors.tpl"}
<FORM method=post enctype="multipart/form-data">
    <h2 class="h2"> Enregistrement d'une Video </h2>
    <TABLE BORDER=0>
        <TR>
            <TD class="td">Titre</TD>
            <TD>
                <input type="text" name="titre" id="titre"><br>
            </TD>
        </TR>
        <TR>
            <TD class="td">Video</TD>
            <TD style="font-size: 12px">
                <input type="file" name="upload" id="upload"><br>
                <div id="duration">Please choose a video</div>
                <input type="hidden"  name="duree" id="duree">
            </TD>
        </TR>


        <TR>
            <TD class="td">Package</TD>
            <TD>
                <SELECT name="package" id="package" style="font-size: 12px" onchange="changeTest()">
                    <OPTION VALUE="500">500 Vues</OPTION>
                    <OPTION VALUE="1000">1000 Vues</OPTION>
                    <OPTION VALUE="1500">1500 Vues</OPTION>
                    <OPTION VALUE="2000">2000 Vues</OPTION>
                    <OPTION VALUE="2500">2500 Vues</OPTION>
                </SELECT>
                <div id="prix">Prix :</div>
            </TD>
        </TR>

        <TR>
            <td>

            </td>
            <TD COLSPAN=2>
                <INPUT type="submit" name="Submitvideo" class="button_large" id="Submitvideo" value="Acheter">
            </TD>
        </TR>
    </TABLE>
</FORM>