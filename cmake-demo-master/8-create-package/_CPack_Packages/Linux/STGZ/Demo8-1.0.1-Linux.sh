#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo8-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Demo8-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo8 Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo8 will be installed in:"
    echo "  \"${toplevel}/Demo8-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Demo8-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo8-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +162 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Demo8-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� �ݼ_ �[kp��+�!+���@Lʆ�6	�,�B�e[ɚڎ1v-�Z�V�@���"�@��"2L��N�x��H?�2���`B3�tx��4@`�ńBMQ�ݽw�{���0C��Y�=�=���{ή����fi(�."y�޺�xE]�W�1Uz��|EU]M]EM�����VT G��bV�R2!�P����fKW�k�B��[7�8N���z�HUn ����T�
��
�停��c�g��ծަ�,_������/iρB#G���p]ǊTt��7�aR��hg#v���~�O�4��4Ӿru��Xތ�<����� ��2˭�n�<t��&���g�/�����q(���j��#��H8�)��-���$b�J�Nn����[���M��/$NO|�d��3ּ������<q<� Ns�|���w9��8rr�~��pZɧ�����
�^}��Gv^��y�����˻�W�����wܼ��{~��=�
����xN뉿~��DG�H�����,p����X���B������߮�ir��V���Y/A%���l���5,&��L�寕��P��.z?�邹���\��눾�@��	�;��v���H��I�t�u�4ɧ��
^�^t�A0���E�I9����B9����(���P8���@�"~���P �H"����{5ñmR<�-]mbP�K�,Żښ"����@FR0 �35?�bQ����>��Ʉ�倶�`_"A�qq��mlmil+=���[�"7�_f?I.`���L��/"���|��8�F�ʯ��q��BGt���0�����w��^��<e�R_n��tx������*��t�s{<��m�Ia�EǄ����AR�4~��l�;,�cG�@���A�]rlR�OaW�ظ"�2������C{i���oR��G�;�Z���
l�=EU
[��1}�Ӑǿ��lV����-��=\X3#�ޓ/�&<��6��'}$�)��^%��	\��?��{jQ�Yy���څԴ���z�;(>+�@�7�q�V��Z�j(Y.�������)v�[�T�xJ�����@��.l��DHiV�9|�ѐ����JN��|�v��n���=�M~�;YH�&<�06���t�(�I�jIw@�e`ƆXitܡ(�4��!���q!�&in�&@Z�2��T���O��t�5P?t���?4udJs���Q
�8�zUS�l|�NxJL���	���	��S���S��G��ԩ�����Σ(�$��׼�?���f����E��W��n��C����gb�o�osK�5_��R��ve��a~�/�EK��֕�)s��/�S�3�y�} �o��lM�nM}ڜ�З^��0:�	k�J�k��=�[}=��>qbof�?� k�������Y�'±(_����;���!�/��xid���̫~{l�M�a#�c�8���� [j<���Q� ����	�t�yJL����6��}34/�}g��> ����������/�:7���ɦ�����Չ�7��0߱��wc�: �kt%��#t5��<���
.�W���9v���׮���*j��=z����
��3j]�����T�g;%��;�6u�;�t�'>LC���ot��5�J��]���F׊s���<�U?���j���}.�ϵ��Ń�7��s�(\%�g������È>�~&����9�k�����"ӱ^L8}/e�?9�Vb��Χ�X���g�I����m��J�"#�g�y>�1�%��o��\D��7�y�z�N���o!�L{�}�����Τ+4M�$�3"�� �����Ӥ�	����M�g%z����t-���/��|����-�J*R���o�J=�<��k�&����e�ۑl��h�ψ�j�Έ�i�ӈ�k�f��x�m^q�6��x���h�/BӦ��x8�p�D�3~���������D�'��Bm0◚�O;�L[�F<�oT�lO�/���:�A�Y�6�7/�o.�3�2��3x�RF�>t�oP��a��cp��os&���E��,p��>��-@�-dS���S~/ɪ����"m�SzK����}�ۮϔ���Vȩ���[�����Ù���s�~{g�g��8�x�6<ř�M�9�x�^�|~a�Op��I�v��3����3���	��q^���/g9����f)���k�ͼ�km���<����rBN�B�~�����؏�	 ���X_ "�X<!�#�?64�d)詫]So���c�@<�.�#ߎB���$�CC��D')�*�x��v6$��2x	��N_�_��7����c���8�q����v_[K�Q��z6�w�~�d'4w���D3�غ���*nڰ�&���kl��_5ք#[� �o�R�_L�b��zK�R�i8���n�2F�Vȓ�>$���q��;h�F�hL�<�Ɩ290@��h�ӗG�e� R��@by�ۣ���帚r��~��R$���pD�EBc�g 7�4��z�1��=� ����xFRMՉ�Z�{(!0���y`U��5Y~�M؏��&�?[����1�rd����GxF?��+{zn���Y��)�ݩ==_R�Kpz�d�c�H�m�==�R��p����ٌ��D�y�r�?Qb�o+R}jOϵ�{���~;R}*��/�<2�?���ڧ���g��L�l��%��D��i�{u����?�2��0����O�Ď����s�;}7����s<�l9�sƞUx��k�F=���s��q4���D��K���Xԟғ���{J��c�?B�
f³忌Գ�?��[����
\�:{z.�w��o#��}潰*���y�G�p(;�1V�ʽ�����Ώnc9�=�i�Q{z�s��������� j���^���yĞ�#�9�A��@Ww=�]��-L�l��[���p��Y��
G�#ɠT�������Q��뭭�����뭬վ�������TU���}��uPy9/J�:�ɸ�cÊ/Ã��'$YG|(绒�9���'M��ߍ����7�lj�|7l��+,[�!��tBq���P��d�w�����m�CėZ�,_�/OF!7^�m������M�\s��]�F?��n��X��k�j��uuհ�������Zhy8��1X^�NQЖ/����J�(��$�ԼMXA�u5��2u�Z�s��Cs��A�p��ϸ���Y�UUe5��ou��jn���@��zg9o$oֽ׀Wj
�x����>]��+΋���1UO��Y�5�[�O4L54�^'��3G�qfh��gh �E�����=�/e���ן�KW�o>p̍��̾ɰ"�wL�����⍷=�ӧ��W�vd���n���vYZ�\�z�wC&�y�ͼ��Îkw&���n���X���\i�^�(����2�u�o'fZ0���!�D���B�c�[�M?������Ϳ����G-�˖�c�k_����nۡ���6�_eQ>�&u��GLoGi2��$�����l6~^��s����8��:��
L�b3�@�`�s���R���563Gs4Gst1�?�M� :  