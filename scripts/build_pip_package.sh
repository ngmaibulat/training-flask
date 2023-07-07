pip install build
pip install twine

rm -fr dist

python -m build --sdist .
python -m build --wheel .

ls ~/.pypirc

python -m twine upload dist/*
